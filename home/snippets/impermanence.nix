{
  home.persistence."/persist/home/severin" = {
    directories = [ # Make sure to backup the directory to the persist location BEFORE `hm switch`/reboot
      ".ssh"
      ".thunderbird"
      ".local/share/PrismLauncher"
      ".config/vesktop"
      ".config/Signal"
      ".config/spotify"
      "Documents"
      "dotfiles"
    ];
    allowOther = true; # to be used with # programs.fuse.userAllowOther = true; # in nixos config
  };

  # This is probably the most important part at user site because it gets home-manager running
  bootstrap-home-manager = {
    enable = true;
    dotfiles.path = ./../..;
    dotfiles.flake = "severin";
  };
}
