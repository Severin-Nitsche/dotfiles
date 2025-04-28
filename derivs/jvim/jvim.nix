repo: { pkgs, ... }: {
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  home.file.".config/nvim" = {
    recursive = true;
    source = "${repo}/.config/nvim";
  };

  # home.packages = [
  #   pkgs.skimpdf
  # ];
}
