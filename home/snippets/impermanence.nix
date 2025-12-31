let
  prefixAll = prefix: map (x: "${prefix}/${x}");
in {config, lib, ...}: {
  home.persistence."/persist${config.home.homeDirectory}" = {
    directories = 
    map (lib.removePrefix config.home.homeDirectory) (
      # Make sure to backup the directory to /persist
      prefixAll config.home.homeDirectory [
        ".ssh"
        ".thunderbird"
        "Documents"
        "dotfiles"
      ]
      ++ prefixAll config.xdg.configHome [
        "vesktop"
        "Signal"
        "spotify"
        "libreoffice"
      ]
      ++ prefixAll config.xdg.dataHome [
        "PrismLauncher"
        "Steam"
      ]
    );
    allowOther = true; 
    # to be used with 
    # programs.fuse.userAllowOther = true; 
    # in nixos config
  };

  # This gets home-manager running on impermanent home
  bootstrap-home-manager = {
    enable = true;
  };
}
