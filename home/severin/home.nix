{ config, pkgs, nixpkgs, ... }: {

  imports = [
    ../snippets/impermanence.nix
    ../snippets/git.nix
    ../snippets/eza.nix
    ../snippets/discord.nix
    ../snippets/rbw.nix
    ../snippets/spicetify.nix
    ../snippets/tmux.nix
    ../snippets/hyprland.nix
    ../snippets/vim.nix
    ../snippets/stylix/stylix.nix
  ];
  
  config = {
    home.username = "severin";
    home.homeDirectory = "/home/severin";
  
    home.stateVersion = "24.05"; # Never Change
  
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = with (import ../../overlays); [
      additions
      modifications
    ];
  
  
    home.packages = with pkgs; [
      vpn-rbw

      bat
      hexyl
      tlrc
  
      signal-desktop
      thunderbird
      rustdesk
  
      jetbrains.idea-ultimate
      jetbrains.webstorm
      vscode
  
      alacritty
      geogebra6
      postman
      firefox
      prismlauncher
      obs-studio
      anki-bin
      obsidian
    ];
  
    programs.bash.enable = true;
    systemd.user.settings.Manager.DefaultLimitNOFILE="8192:524288";
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
