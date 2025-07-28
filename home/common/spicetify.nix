{ pkgs, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in { 
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      trashbin
      playNext
    ];
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
      historyInSidebar
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "latte";
  };
}
