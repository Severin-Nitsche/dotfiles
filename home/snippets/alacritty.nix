{ pkgs, ... }: {
  programs.alacritty.settings = {
    mouse.hide_when_typing = true;

    terminal.shell.program = "${pkgs.tmux}/bin/tmux";
  };
}
