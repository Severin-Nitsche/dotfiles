repo: { pkgs, lib, programs, ... }: {

  programs.neovim.vimAlias = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  home.file.".config/nvim" = {
    recursive = true;
    source = "${repo}/.config/nvim";
  };

  home.packages = [
    pkgs.skimpdf
  ];
}
