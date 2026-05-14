{ lib, ... }: {

  imports = [];

  options = {};

  config = {
    programs.vim.enable = true;
    programs.vim.settings.expandtab = true;
    programs.vim.settings.mouse = "a";
    programs.vim.settings.number = true;
    programs.vim.settings.shiftwidth = 2;
    programs.vim.extraConfig = ''
      set textwidth=80

      "https://kitsugo.com/guide/netrw-improvements/
      let g:netrw_banner = 0
      let g:netrw_altv = 1
      let g:netrw_browse_split = 4
      let g:netrw_liststyle = 3
      let g:netrw_winsize = 20

      augroup InitNetrw
        autocmd!
        autocmd VimEnter * if expand("%") == "" | Lexplore | endif
      augroup END
    '';
  };

}
