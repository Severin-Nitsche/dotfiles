{ pkgs, ... }: {

  imports = [];

  options = {};

  config = {
    programs.rbw.enable = true;
    programs.rbw.settings.base_url = "https://bitwarden.keki-nas.synology.me";
    programs.rbw.settings.email = "severinnitsche@gmail.com";
    programs.rbw.settings.pinentry = pkgs.pinentry-tty;
  };

}
