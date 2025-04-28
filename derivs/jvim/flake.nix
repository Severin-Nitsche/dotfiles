{
  description = "Julius' neovim";

  inputs = {
    dotfiles.url = "git+ssh://git@github.com/TheodosiusVelco/Dotfiles.git";
    dotfiles.flake = false;
  };

  outputs = { self, dotfiles }: {

    homeManagerModules.default = (import ./jvim.nix) dotfiles;

  };
}
