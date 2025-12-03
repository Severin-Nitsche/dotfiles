{ lib, config, pkgs, ... }: {

  options.bootstrap-home-manager = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to bootstrap home-manager. (This requires a bootstrapped/present systemd for the user.)";
    };
  };

  config = let
    cfg = config.bootstrap-home-manager;
  in lib.mkIf cfg.enable {
    systemd.user.enable = true;
    systemd.user.services.home-manager = {
      Unit.Description = "Activate home-manager";
      Unit.DefaultDependencies = false;
      Unit.Before = [
        "bluetooth.target"
        "basic.target"
        "default.target"
        "paths.target"
        "sockets.target"
        "timers.target"
      ];
      Unit.X-RestartIfChanged = false; # Hopefully this makes the environment variable obsolete
      Install.WantedBy = [ "paths.target" ];
      Service = {
        Type = "oneshot";
        Environment="PATH=${pkgs.home-manager}/bin:${pkgs.coreutils}/bin:${pkgs.nix}/bin:${pkgs.systemd}/bin";
        RemainAfterExit = true;
        ExecStart = "${config.xdg.configHome}/systemd/user/activate.sh";
      };
    };
    xdg.configFile."systemd/user/activate.sh".force = true;
    xdg.configFile."systemd/user/activate.sh".text = "";
    home.activation.home-manager = lib.hm.dag.entryBetween [ "reloadSystemd" ] [ "writeBoundary" "linkGeneration" ] ''
      run rm "$HOME/.config/systemd/user/activate.sh"
      run cat > "$HOME/.config/systemd/user/activate.sh" <<EOF
      #!${pkgs.bash}/bin/bash
      exec $(readlink -f $0) --driver-version 1
      EOF
      run chmod +x "$HOME/.config/systemd/user/activate.sh"
    '';
  };
}
