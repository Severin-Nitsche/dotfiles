{ ... }: {

  imports = [];

  options = {};

  config = {
    programs.eza.enable = true;
    programs.eza.enableBashIntegration = true;
    programs.eza.enableZshIntegration = true;
  };

}
