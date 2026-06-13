{ lib, config, pkgs, ... }: {

  options.hyprconf = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = ''
      Convert settings
      Lists generate multiple hl.* calls, within that lists are for multiple
      arguments, so to call hl.foo([bar]) write settings.foo = [[[bar]]]
      Format: { submap = { <settings> }; ... }
      This will be translated to hyprlands extraconfig.
      extraConfig = toSettings {
        bind = [
          {
            keys = [string] | string;
            * = *;
            flags.* = boolean;
          }
        ];
        submap.<name> = { <settings> };
        extraConfig = "";
        * = *; # hl.*
      };
    '';
  };

  config = let
    toSettings = (import ./-hyprconf.nix) lib;
  in {
    wayland.windowManager.hyprland.extraConfig = toSettings config.hyprconf;
  };

}
