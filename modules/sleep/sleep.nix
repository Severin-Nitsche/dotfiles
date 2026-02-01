{ pkgs, lib, config, ... }:
let cfg = config.sleep; in {

  imports = [];

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
    user.enable = mkEnableOption "user sleep.target, lock.target, unlock.target";
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
    mkUnit = _: generic: {
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
    };
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
      after = device.before;
      path = if device.hot-reset then
        [ cfg.hot-reset.package ] ++ drivers
      else drivers;
      afterSleep = if device.defer then
        "${remove}\n${reload}"
      else reload;
      beforeSleep = if device.defer then "" else remove;
    };
  in {
    systemd.targets.sleep = {
      conflicts = cfg.exclude; # Prefer sleep.target
      after = cfg.exclude; # Shutdown before sleep starts
      onSuccess = cfg.exclude; # Start after sleep stops
    };
    systemd.services = builtins.mapAttrs mkUnit cfg.generic;

    sleep.generic = builtins.mapAttrs mkGeneric cfg.reset;

    systemd.user.targets.sleep = {
      conflicts = cfg.user.exclude;
      after = cfg.user.exclude;
      onSuccess = cfg.user.exclude;
    };
    services.systemd-lock-handler.enable = cfg.user.enable;
    services.systemd-lock-handler.package = (import ./overlay.nix) pkgs;
    systemd.user.services = builtins.mapAttrs mkUnit cfg.user.generic;
  };
}
