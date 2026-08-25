{ pkgs, ... }: {

  imports = [
    ./rofi.nix
    ./alacritty.nix
  ];

  options = {};

  config = {
    wayland.windowManager.niri = {
      enable = true;
      extraConfig = builtins.readFile ./niri.kdl;
    };
  };

}
