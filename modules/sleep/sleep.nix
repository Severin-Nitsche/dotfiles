dsd: plugins: wait: { pkgs, lib, config, ... }:
let cfg = config.sleep; in {

  imports = [ dsd ];

  options.sleep = with lib; {
    generic = mkOption {
      type = types.attrsOf (
        types.submodule ((import ./generic.nix) true)
      );
      default = { };
      description = ''
        Various commands to run at/after reaching sleep.target.
      '';
    };
    barriers = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable barrier services.

        If enabled, special services `userbarrier` in system space and
        `systembarrier` in user space will start with the respecting sleep
        target. System services which choose to order themselves `after` the
        userbarrier will enable user services choosing to order `before` the
        systembarrier to be executed before them upon sleep and after them on
        resume.
      '';
    };
    reset = mkOption {
      type = types.attrsOf (
        types.submodule ((import ./device.nix) pkgs)
      );
      default = { };
      description = ''
        Drivers / PCI devices to (hot) reset after sleep.
      '';
    };
    hot-reset.package = mkOption {
      type = types.package;
      description = ''
        The package to use for hot resets.
      '';
    };
    exclude = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        System services to stop before sleeping and restart afterwards.
      '';
    };
    user.enable = mkEnableOption "user sleep.target";
    user.generic = mkOption {
      type = types.attrsOf (
        types.submodule ((import ./generic.nix) false)
      );
      default = { };
      description = ''
        Various commands to run at/after reaching sleep.target in user space.
      '';
    };
    user.exclude = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        User services to stop begore sleeping and (re)start afterwards.
      '';
    };
  };

  config = let
    mkUnit = _: generic: lib.recursiveUpdate {
      enable = generic.enable;
      description = generic.description;
      name = generic.name + ".service";
      wantedBy = [ "sleep.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
      };
      unitConfig = {
        StopWhenUnneeded = "yes";
        DefaultDependencies = "no";
      };
      path = generic.path;
      script = generic.beforeSleep;
      preStop = generic.afterSleep;
      before = [ "sleep.target" ] ++ builtins.map (x: x + ".service") generic.before;
      after = builtins.map (x: x + ".service") generic.after;
    } generic.passthru;
    mkGeneric = _: device: let
      drivers = builtins.concatMap
        (driver: driver.packages) device.drivers;
      insert = lib.concatMapStringsSep 
        "\n" (driver: driver.insert) device.drivers;
      remove = lib.concatMapStringsSep 
        "\n" (driver: driver.remove) (lib.reverseList
          device.drivers);
      reload = if device.hot-reset then
        "hot-reset ${device.device}\n${insert}" 
      else insert;
    in {
      enable = device.enable;
      description = "Reset the device/drivers for ${device.device}";
      name = device.name;
      before = device.after;
      after = if !device.noBarrier && cfg.barriers && cfg.user.enable then
        [ "userbarrier" ] ++ device.before
      else device.before;
      path = if device.hot-reset then
        [ cfg.hot-reset.package ] ++ drivers
      else drivers;
      afterSleep = if device.defer then
        "${remove}\n${reload}"
      else reload;
      beforeSleep = if device.defer then "" else remove;
    };
  in lib.mkMerge [
    {
      systemd.targets.sleep = {
        conflicts = cfg.exclude; # Prefer sleep.target
        after = cfg.exclude; # Shutdown before sleep starts
        onSuccess = cfg.exclude; # Start after sleep stops
      };
      systemd.services = builtins.mapAttrs mkUnit cfg.generic;

      sleep.generic = builtins.mapAttrs mkGeneric cfg.reset;
    }
    (lib.mkIf cfg.user.enable {
      systemd.user.targets.sleep = {
        conflicts = cfg.user.exclude;
        after = cfg.user.exclude;
        onSuccess = cfg.user.exclude;
      };
      dbus-systemd-dispatcher.enable = true;
      dbus-systemd-dispatcher.plugins = [ plugins.sleep ];
      systemd.user.services = builtins.mapAttrs mkUnit cfg.user.generic;
    })
    (let
      sync = rsig: ssig: receiver: sender: ''
        dbus-wait \
        path ${sender} \
        interface systemd.signal \
        member ${rsig} -- \
        \
        dbus-send --system \
        ${receiver} \
        systemd.signal.${ssig}

        dbus-send --system \
        ${receiver} \
        systemd.signal.${ssig}
      '';
      sender = sender: receiver:
        sync "stop" "stopped" receiver sender;
      receiver = receiver: sender:
        sync "stopped" "stop" sender receiver;
    in lib.mkIf (cfg.barriers && cfg.user.enable) {
      sleep.generic.userbarrier = {
        description = "Synchronizer with user space";
        path = [ pkgs.dbus wait ];
        passthru.serviceConfig.Type = "simple";
        beforeSleep = receiver
          "/systemd/system/userbarrier" "/systemd/user/systembarrier";
        afterSleep = sender
          "/systemd/system/userbarrier" "/systemd/user/systembarrier";
      };
      sleep.user.generic.systembarrier = {
        description = "Synchronizer with system space";
        path = [ pkgs.dbus wait ];
        passthru.serviceConfig.Type = "simple";
        beforeSleep = sender
          "/systemd/user/systembarrier" "/systemd/system/userbarrier";
        afterSleep = receiver
          "/systemd/user/systembarrier" "/systemd/system/userbarrier";
      };
    })
  ];
}
