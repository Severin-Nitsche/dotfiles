{
  environment.persistence."/persist" = {
    enable = true;
    directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };
  shadowHack = {
    enable = true;
    persistLocation = "/persist";
    persist.loginDefs = true;
    persist.group = true;
    persist.passwd = true;
    persist.shadow = true;
    persist.subuid = true;
    persist.subgid = true;
  };
  bootstrap-user-systemd = {
    enable = true;
    persistLocation = "/persist";
  };
  programs.fuse.userAllowOther = true; # Allow other users on bindMounts (impermanent /home)
}
