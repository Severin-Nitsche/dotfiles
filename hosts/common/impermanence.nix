{
  environment.persistence."/persist" = {
    enable = true;
    directories = [
      "/var/lib/nixos" # Needed for stable g/uids
      "/var/lib/systemd"
      "/etc/NetworkManager/system-connections"
      "/var/lib/bluetooth"
    ];
    files = [
      "/etc/machine-id"
    ];
  };
  services.journald.storage = "volatile";
  shadowHack = {
    enable = true;
    persistLocation = "/persist";
    persist.loginDefs = false; # fails currently
    persist.group = true;
    persist.passwd = true;
    persist.shadow = true;
    persist.subuid = true;
    persist.subgid = true;
    persist.gshadow = false; # does not seem to exist on nixos
  };
  bootstrap-user-systemd = {
    enable = true;
    persistLocation = "/persist";
  };
  programs.fuse.userAllowOther = true; # Allow other users on bindMounts (impermanent /home)
}
