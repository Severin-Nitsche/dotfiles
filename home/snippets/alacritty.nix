{ pkgs, ... }: {
  programs.alacritty.settings = {
    mouse.hide_when_typing = true;

    terminal.shell.program = "${pkgs.tmux}/bin/tmux";

    keyboard.bindings = [
      {
        key = "E";
        mods = "Control";
        command.program = "${pkgs.tmux}/bin/tmux";
        command.args = [ "kill-session" ];
      }
    ];
  };
}
