{ ... }: {

  imports = [];

  options = {};

  config = {
    programs.zsh.enable = true;
    programs.zsh.enableCompletion = false;
    programs.zsh.autosuggestion.enable = true;
  };

}
