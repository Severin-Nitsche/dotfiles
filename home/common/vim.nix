{ ... }: {

  imports = [];

  options = {};

  config = {
    programs.vim.enable = true;
    programs.vim.settings.expandtab = true;
    programs.vim.settings.mouse = "a";
    programs.vim.settings.number = true;
    programs.vim.settings.shiftwidth = 2;
  };

}
