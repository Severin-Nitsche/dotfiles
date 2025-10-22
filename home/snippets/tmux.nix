{ ... }: {

  imports = [];

  options = {};

  config = {
    programs.tmux.enable = true;
    programs.tmux.keyMode = "vi";
    programs.tmux.shortcut = "a";
    programs.tmux.clock24 = true;
    programs.tmux.customPaneNavigationAndResize = true;
    programs.tmux.newSession = true;
    programs.tmux.terminal = "xterm-256color";
  };

}
