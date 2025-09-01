{
  home.persistence."/persist/home/severin" = {
    directories = [
      ".ssh"
      "Documents"
    ];
    allowOther = true; # to be used with # programs.fuse.userAllowOther = true; # in nixos config
  };
}
