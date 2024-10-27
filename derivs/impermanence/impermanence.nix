{
  environment.persistence."/persist" = {
    enable = true;
    directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };
}
