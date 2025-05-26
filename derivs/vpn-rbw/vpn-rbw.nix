{ writeShellApplication, rbw, openconnect }:
writeShellApplication {
  name = "vpn";
  runtimeInputs = [ rbw openconnect ];
  text = (builtins.readFile ./vpn.sh);
}
