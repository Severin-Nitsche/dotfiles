{ config, pkgs, nixpkgs, lib, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "severinnitsche";
  home.homeDirectory = "/Users/severinnitsche";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      trashbin
      history
      playNext
    ];
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "latte";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    bat
    hexyl
    tlrc
    openconnect
    discord
    # steam
    jetbrains.idea-ultimate
    jetbrains.webstorm
    jetbrains.pycharm-professional
    # vscode
    zed-editor
    iterm2
    # rustdesk
    geogebra6
    # spotify
    signal-desktop
    postman
    # obs-studio # Not supported / wrog os
    anki-bin
    obsidian
    inkscape
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".ssh/config".text = ''
      Host github.com
        AddKeysToAgent yes
        IdentityFile ~/.ssh/github
      Host *.hpc.itc.rwth-aachen.de
        AddKeysToAgent yes
        IdentityFile ~/.ssh/claix
    '';
  };

  home.shellAliases = {
    sudo = "sudo ";
    eastvpn = "openconnect --protocol=anyconnect https://vpn.rwth-aachen.de --useragent=AnyConnect -b";
    killvpn = "killall openconnect";
    vpn = "eastvpn -u ll464721 --authgroup=\"RWTH-VPN (Full Tunnel)\"";
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
  #  /etc/profiles/per-user/severinnitsche/etc/profile.d/hm-session-vars.sh
  #
  programs.vim.enable = true;
  programs.vim.defaultEditor = true;
  programs.vim.settings.expandtab = true;
  programs.vim.settings.mouse = "a";
  programs.vim.settings.number = true;
  programs.vim.settings.shiftwidth = 2;

  programs.git.enable = true;
  programs.git.userEmail = "severinnitsche@gmail.com";
  programs.git.userName = "Severin Nitsche";

  programs.eza.enable = true;
  programs.eza.enableBashIntegration = true;
  programs.eza.enableZshIntegration = true;
  # programs.eza.icons = "auto";

  programs.zsh.enable = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.autosuggestion.strategy = [
    "history"
    "completion"
  ];
  programs.zsh.completionInit = ''
    autoload -U compinit && compinit
    bindkey '^I' forward-word
    bindkey '^[[Z' autosuggest-accept
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
