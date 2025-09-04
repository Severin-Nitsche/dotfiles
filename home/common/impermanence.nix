{
  home.persistence."/persist/home/severin" = {
    directories = [
      ".ssh"
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
