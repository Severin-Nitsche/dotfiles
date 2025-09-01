{ lib, config, pkgs, ... }: {

  options.bootstrap-home-manager = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to bootstrap home-manager. (This requires a bootstrapped/present systemd for the user.)";
    };
    dotfiles.path = lib.mkOption {
      type = lib.types.path;
      description = "Persistent location of the configuration.";
    };
    dotfiles.flake = lib.mkOption {
      type = lib.types.string;
      description = "The flake output of the home configuration.";
    };
  };

  config = let
    cfg = config.bootstrap-home-manager;
  in lib.mkIf cfg.enable {
    systemd.user.enable = true;
    systemd.user.services.home-manager = {
      Unit.Description = "Activate home-manager";
      Install.WantedBy = [ "default.target" ];
      Service = {
        Type = "simple";
        Environment="PATH=${pkgs.home-manager}/bin:${pkgs.coreutils}/bin:${pkgs.nix}/bin:${pkgs.systemd}/bin";
        ExecStart = pkgs.writeShellScript "activate-home-manager" ''
          if [ -z ''${HOME_MANAGER_ACTIVATE+x} ]; then
            export HOME_MANAGER_ACTIVATE=1;
          else
            exit;
          fi
          exec home-manager switch --flake ${builtins.path {path=cfg.dotfiles.path; recursive=true;}}#${cfg.dotfiles.flake}
        '';
      };
    };
  };
}
