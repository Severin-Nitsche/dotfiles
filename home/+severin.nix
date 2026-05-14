{ config, pkgs, nixpkgs, ... }: {

  imports = [
    ./bash.nix
    ./impermanence.nix
    ./git.nix
    ./eza.nix
    ./discord.nix
    ./firefox.nix
    ./rbw.nix
    ./spicetify.nix
    ./tmux.nix
    ./hyprland.nix
    ./vim.nix
    ./stylix/stylix.nix
  ];
  
  config = {
    home.username = "severin";
    home.homeDirectory = "/home/severin";
  
    home.stateVersion = "24.05"; # Never Change
  
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = with (import ../overlays); [
      additions
      modifications
    ];
  
  
    home.packages = with pkgs; [
      # Command line
      vpn-rbw
      bat
      hexyl
      tlrc
  
      # Desktop
      signal-desktop
      thunderbird
      rustdesk
      libreoffice
      gnome-calculator
      simple-scan
  
      # Dev
      jetbrains.idea
      jetbrains.webstorm
      vscode
  
      # Miscellaneous
      geogebra6
      postman
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
