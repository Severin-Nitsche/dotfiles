{ ... }: {

  imports = [];

  options = {};

  config = {
    programs.git.enable = true;
    programs.git.settings.user.email = "severinnitsche@gmail.com";
    programs.git.settings.user.name = "Severin Nitsche";
  };

}
