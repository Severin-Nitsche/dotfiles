lucide: { config, lib, pkgs, ... }: {

  options.lucide = with lib; {
    enable = mkEnableOption "Lucide icons";

    icons = mkOption {
      type = let
        target_type = types.submodule {
          options = {
            icon = mkOption {
              type = types.str;
            };
            color = mkOption {
              type = types.str;
            };
          };
        };
      in types.listOf (types.coercedTo types.str
      (icon: {icon = icon; color = "currentColor";}) target_type);
    };

    getIcon = mkOption {
      type = types.uniq types.raw;
    };

    getSingleIcon = mkOption {
      type = types.uniq types.raw;
    };
  };

  config = lib.mkIf config.lucide.enable {
    lucide.getIcon = icon: col:
      let color = if isNull col || col == "" then
        "currentColor"
        else col;
      in lib.throwIfNot
        (lib.elem {icon = icon; color = color;} config.lucide.icons)
        "Lucide icon ${icon} in ${color} is not registered" 
        (pkgs.stdenv.mkDerivation {
          name = "Lucide";
          src = "${lucide}/icons/";
          dontBuild = true;
          buildPhase = ''
            substituteInPlace "${icon}.svg" \
              --replace-fail currentColor "${color}"
          '';
          dontConfigure = true;
          installPhase = with lib; let
            install = concatMapStringsSep "\n" ({icon, color}: ''
              cp ${escapeShellArg icon}.svg\
                $out/${escapeShellArg icon}-${escapeShellArg color}.svg
              substituteInPlace \
                $out/${escapeShellArg icon}-${escapeShellArg color}.svg \
                --replace-fail currentColor ${escapeShellArg color}
            '') config.lucide.icons;
          in ''
            mkdir -p $out
            ${install}
          '';
        }) + "/${lib.escapeShellArg icon}-${lib.escapeShellArg color}.svg";

    lucide.getSingleIcon = icon: color:
      (pkgs.stdenv.mkDerivation {
        name = "${icon}-${color}";
        src = "${lucide}/icons/";
        buildPhase = ''
          substituteInPlace "${icon}.svg" \
            --replace-fail currentColor "${color}"
        '';
        dontConfigure = true;
        installPhase = ''
          mkdir -p $out
          cp "${icon}.svg" "$out/${icon}.svg"
        '';
      }) + "/${icon}.svg";
  };

}
