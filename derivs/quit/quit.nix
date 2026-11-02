{ writeShellApplication, coreutils, tmux, quickshell }:
writeShellApplication {
  name = "quit";
  runtimeInputs = [ coreutils tmux quickshell ];
  text = (builtins.readFile ./quit.sh);
}
