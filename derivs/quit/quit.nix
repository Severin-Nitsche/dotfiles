{ writeShellApplication, coreutils, tmux, hyprland }:
writeShellApplication {
  name = "quit";
  runtimeInputs = [ coreutils tmux hyprland ];
  text = (builtins.readFile ./quit.sh);
}
