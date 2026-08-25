{ config, pkgs, lib, nixpkgs, ... }: {

  # TODO Die hässlichen Hyprland-Dialoge des Share-Pickers ändern
  # TODO Einfacher Wechsel zwischen hellen und dunklem Thema
  # TODO Einfach zu wechselndes Hintergrundbild von Unsplash oder Pixabay
  # TODO Unterstützung für Tray-Anwendungen
  # TODO Dock bzw. Desktop-Übersicht
  # TODO Konsistentes Verhalten zwischen Wischgeste und Maustasten zum
  # Desktopwechseln

  imports = [
    ./bash.nix
    ./impermanence.nix
    ./git.nix
    ./eza.nix
    ./discord.nix
    ./firefox.nix
    ./niri.nix
    ./rbw.nix
    ./tmux.nix
    ./hyprland.nix
    ./vim.nix
  ];
  
  config = {
    home.username = "severin";
    home.homeDirectory = "/home/severin";
  
    home.stateVersion = "24.05"; # Never Change
  
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
      "electron-39.8.10"
      "pnpm-10.29.2"
    ];
    nixpkgs.overlays = with ((import ../overlays) lib); [
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
      spotify
      bitwarden-desktop
      signal-desktop
      thunderbird
      libreoffice
      gnome-calculator
      simple-scan
  
      # Dev
      # jetbrains.idea
      # jetbrains.webstorm
      # vscode
  
      # Miscellaneous
      geogebra6
      prismlauncher
      obs-studio
    ];

    # Manage Keyboard Layouts
    xdg.configFile."xkb".source = ./xkb;
    xdg.configFile."xkb".recursive = true;

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
