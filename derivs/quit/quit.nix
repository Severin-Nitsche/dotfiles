{ writeShellApplication, coreutils, tmux }:
writeShellApplication {
  name = "quit";
  runtimeInputs = [ coreutils tmux ];
  text = (builtins.readFile ./quit.sh);
}
