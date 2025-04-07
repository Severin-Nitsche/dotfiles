{ pkgs, ... }: {
  home.packages = with pkgs; [
    (writeShellScriptBin "fix-Launchpad" (builtins.readFile ./fixup.sh))
  ];
}
