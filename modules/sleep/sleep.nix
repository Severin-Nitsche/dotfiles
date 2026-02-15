dsd: plugins: wait: { pkgs, lib, config, ... }:
let cfg = config.sleep; in {

  imports = [ dsd ];

  options.sleep = with lib; let
    common = system: let
      space = if system then "system" else "user";
      Space = lib.toSentenceCase space;
    in {
      generic = mkOption {
        type = types.attrsOf (
          types.submodule ((import ./generic.nix) system)
        );
        default = { };
        description = ''
          Various commands to run at/after reaching (${space}) sleep.target.
        '';
      };
      exclude = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = ''
          ${Space} services to stop before sleeping and (re)start afterwards.
        '';
      };
    };
  in {
    enable = mkEnableOption "Sleep convenience module";
    user = {
      enable = mkEnableOption "User sleep convenience module";
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
    } // (common false);
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
  } // (common true);

  config = let
    helpers = (import ./helpers.nix) cfg lib;
  in lib.mkIf cfg.enable (lib.mkMerge [
    {
      systemd.targets.sleep = {
        conflicts = cfg.exclude; # Prefer sleep.target
        after = cfg.exclude; # Shutdown before sleep starts
        onSuccess = cfg.exclude; # Start after sleep stops
      };
      systemd.services = builtins.mapAttrs helpers.mkUnit cfg.generic;

      sleep.generic = builtins.mapAttrs helpers.mkGeneric cfg.reset;
    }
    (lib.mkIf cfg.user.enable (lib.mkMerge [
      {
        systemd.user.targets.sleep = {
          conflicts = cfg.user.exclude;
          after = cfg.user.exclude;
          onSuccess = cfg.user.exclude;
        };
        systemd.user.services = builtins.mapAttrs helpers.mkUnit cfg.user.generic;

        dbus-systemd-dispatcher.enable = true;
        dbus-systemd-dispatcher.plugins = [ plugins.sleep ];
      }
      (lib.mkIf cfg.user.barriers {
        sleep.generic.userbarrier = {
          description = "Synchronizer with user space";
          path = [ pkgs.dbus wait ];
          passthru.serviceConfig.Type = "simple";
          beforeSleep = helpers.receiver
            "/systemd/system/userbarrier" "/systemd/user/systembarrier";
          afterSleep = helpers.sender
            "/systemd/system/userbarrier" "/systemd/user/systembarrier";
        };
        sleep.user.generic.systembarrier = {
          description = "Synchronizer with system space";
          path = [ pkgs.dbus wait ];
          passthru.serviceConfig.Type = "simple";
          beforeSleep = helpers.sender
            "/systemd/user/systembarrier" "/systemd/system/userbarrier";
          afterSleep = helpers.receiver
            "/systemd/user/systembarrier" "/systemd/system/userbarrier";
        };
      })
    ]))
  ]);
}
