{ ... }: {

  imports = [];

  options = {};

  config = {
    programs.git.enable = true;
    programs.git.userEmail = "severinnitsche@gmail.com";
    programs.git.userName = "Severin Nitsche";
  };

}
