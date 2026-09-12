{ pkgs, ... }: {

  imports = [
    ./rofi.nix
    ./alacritty.nix
  ];

  options = {};

  config = {
    home.packages = with pkgs; [ 
      brightnessctl
      # pamixer
      playerctl

      nautilus
      # udiskie
      runapp

      route159 # NixOS font
      dunst
    ];

    wayland.windowManager.niri = {
      enable = true;
      extraConfig = builtins.readFile ./niri.kdl;
    };
  };

}
