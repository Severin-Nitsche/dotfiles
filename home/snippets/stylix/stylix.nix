{ pkgs, ... }: {
  stylix.enable = true;
  stylix.base16Scheme = ./nixos.yaml;
  stylix.image = ./wallpaper.jpg;
  stylix.fonts = {
    serif = {
      package = pkgs.cinzel;
      name = "Cinzel";
    };
    sansSerif = {
      package = pkgs.route159;
      name = "Route 159";
    };
    monospace = {
      package = pkgs.fira-code;
      name = "Fira Code";
    };
    sizes = {
      desktop = 13;
    };
  };
  stylix.icons = {
    enable = true;
    package = pkgs.vimix-icon-theme;
    light = "Vimix";
    dark = "Vimix";
  };
  stylix.targets.librewolf.profileNames = [ "default" ];
}
