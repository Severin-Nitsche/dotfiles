{ writeShellApplication, coreutils, awww }:
writeShellApplication {
  name = "wfetch";
  runtimeInputs = [ coreutils awww ];
  text = (builtins.readFile ./wfetch.sh);
}
