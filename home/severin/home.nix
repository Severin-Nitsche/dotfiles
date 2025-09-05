{ config, pkgs, nixpkgs, ... }: {

  imports = [
    ../common/impermanence.nix
    ../common/git.nix
    ../common/eza.nix
    ../common/discord.nix
    ../common/rbw.nix
    ../common/spicetify.nix
    ../common/tmux.nix
    ../common/hyprland.nix
  ];
  
  config = {
    home.username = "severin";
    home.homeDirectory = "/home/severin";
  
    home.stateVersion = "24.05"; # Never Change
  
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = with (import ../../overlays); [
      additions
    ];
  
  
    home.packages = with pkgs; [
      vpn-rbw

      bat
      hexyl
      tlrc
  
      signal-desktop
      rustdesk
  
      jetbrains.idea-ultimate
      jetbrains.webstorm
      vscode
  
      alacritty
      geogebra6
      postman
      firefox
      obs-studio
      anki-bin
      obsidian
    ];
  
    programs.bash.enable = true;
    home.sessionVariables = { # These will only be picked up by shells managed through hm
      EDITOR = "vim";
    };

    home.shellAliases = {
      vpn = "vpn ll464721 VPN -- --protocol=anyconnect --useragent=AnyConnect --authgroup=\"RWTH-VPN (Full Tunnel)\" -b https://vpn.rwth-aachen.de";
      killvpn = "sudo killall openconnect";
      dev = "nix develop -i -c bash --norc";
    };
  
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
