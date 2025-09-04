{ config, pkgs, nixpkgs, ... }: {

  imports = [
    ../common/impermanence.nix
    ../common/git.nix
    ../common/eza.nix
    ../common/discord.nix
    ../common/rbw.nix
    ../common/spicetify.nix
    ../common/tmux.nix
  ];
  
  config = {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "severin";
    home.homeDirectory = "/home/severin";
  
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.05"; # Please read the comment before changing.
  
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = with (import ../../overlays); [
      additions
    ];
  
    # Manage Hyprland
    wayland.windowManager.hyprland.enable = true;
    programs.kitty.enable = true;
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, Q, exec, uwsm app -- kitty"
        "$mod, M, exec, uwsm stop" # Do not use exit with uwsm
      ];
      input = {
         kb_layout = "de";
      };
      env = [
        "EDITOR, vim"
      ];
    };
    wayland.windowManager.hyprland.systemd.enable = false; # uwsm compatibility
  
    # The home.packages option allows you to install Nix packages into your
    # environment.
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
  
      dunst
    ];
  
    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;
  
      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };
  
    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/severin/etc/profile.d/hm-session-vars.sh
    #
    # home.sessionVariables = { # These will only be picked up by the login shell
    #   EDITOR = "vim";
    # };

    home.shellAliases = {
      vpn = "vpn ll464721 VPN -- --protocol=anyconnect --useragent=AnyConnect --authgroup=\"RWTH-VPN (Full Tunnel)\" -b https://vpn.rwth-aachen.de";
      killvpn = "sudo killall openconnect";
      dev = "nix develop -i -c bash --norc";
    };
  
    # programs.ssh.enable = true;
  
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
