{ pkgs, ... }: {

  imports = [];

  options = {};

  config = {

    home.packages = [ pkgs.prismlauncher ];
    # Run curseforge via `nix-shell -p appimage-run`
    # to download modpacks
    home.persistence."/persist/home/severin" = {
      directories = [ 
        ".local/share/PrismLauncher"
      ];
    };
  };

}
