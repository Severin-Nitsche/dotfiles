{ writeShellApplication, pciutils }:
writeShellApplication {
  name = "hot-reset";
  runtimeInputs = [ pciutils ];
  text = (builtins.readFile ./hot-reset.sh);
}
