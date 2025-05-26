{ writeShellApplication }:
writeShellApplication {
  name = "fix-Launchpad";
  text = builtins.readFile ./fixup.sh;
}
