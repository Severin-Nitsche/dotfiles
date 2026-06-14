{ pkgs, config, ... }: {
  programs.alacritty.settings = {
    mouse.hide_when_typing = true;

    terminal.shell.program = "${pkgs.tmux}/bin/tmux";

    colors = with config.colors; {
      primary = {
        background = black;
        foreground = white;
      };
      normal = {
        black = black;
        red = norwegian-pink;
        green = zambia-green;
        yellow = indian-gold;
        blue = afghani-blue;
        magenta = chinese-magenta;
        cyan = argentinian-blue;
        white = white;
      };
      bright = {
        black = bright-black;
        red = bright-norwegian-pink;
        green = bright-zambia-green;
        yellow = bright-indian-gold;
        blue = bright-afghani-blue;
        magenta = bright-chinese-magenta;
        cyan = bright-argentinian-blue;
        white = bright-white;
      };
    };
  };
}
