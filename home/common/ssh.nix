{ ... }: {

  imports = [];

  options = {};

  config = {
    home.file = {
      ".ssh/config".text = ''
        Host github.com
          AddKeysToAgent yes
          IdentityFile ~/.ssh/github
        Host *.hpc.itc.rwth-aachen.de
          AddKeysToAgent yes
          IdentityFile ~/.ssh/claix
        Host git-ce.rwth-aachen.de
          AddKeysToAgent yes
          IdentityFile ~/.ssh/git-ce
        Host git.rwth-aachen.de
          AddKeysToAgent yes
          IdentityFile ~/.ssh/gitlab
      '';
    };
  };

}
