{ config, pkgs, nixpkgs, lib, inputs, ... }: {

  imports = [
    ../common/direnv.nix
    ../common/eza.nix
    ../common/git.nix
    ../common/rbw.nix
    ../common/ssh.nix
    ../common/vim.nix
    ../common/jvim.nix
    ../common/zsh.nix

    ../common/discord.nix
    # ../common/spicetify.nix # needs the spicetify input
  ];

  options = {};

  config = {

    home.username = "severinnitsche";
    home.homeDirectory = "/Users/severinnitsche";
  
    home.stateVersion = "24.05"; 
    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = with (import ../../overlays); [
      additions
      # modifications
    ];
  
    home.packages = with pkgs; [
      # Overrides
      vpn-rbw
      fixLaunchpad
      # Shell
      tmux
      bat
      hexyl
      tlrc
      # Utility
      aldente
      iterm2
      # Development
      jetbrains.idea-ultimate
      jetbrains.webstorm
      jetbrains.pycharm-professional
      # postman # random 404
      # Desktop
      geogebra6
      signal-desktop-bin # signal-desktop was not available for macos on unstable
      anki-bin
      obsidian
      inkscape
    ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  
    home.shellAliases = {
      vpn = "vpn ll464721 VPN -- --protocol=anyconnect --useragent=AnyConnect --authgroup=\"RWTH-VPN (Full Tunnel)\" -b https://vpn.rwth-aachen.de";
      killvpn = "sudo killall openconnect";
      dev = "nix develop -i -c bash --norc";
    };
  };
}
