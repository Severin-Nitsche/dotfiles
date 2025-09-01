{ lib, config, pkgs, ... }: {
  options = {
    bootstrap-user-systemd = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether bootstrap user systemd units.";
      };
      persistLocation = lib.mkOption {
        type = lib.types.path;
        description = "Where to expect the persist location.";
      };
    };
  };
  config = let
    cfg = config.bootstrap-user-systemd;
    users = builtins.filter ({isNormalUser, ...}: isNormalUser) (builtins.attrValues config.users.extraUsers);
  in lib.mkIf cfg.enable {
    # environment.persistence.${cfg.persistLocation} = {
    #   enable = true;
    #   directories = builtins.map (
    #     {home, ...}: home + "/.config/systemd"
    #   ) users;
    # };
    systemd.services = builtins.listToAttrs (
      builtins.map (
        {name, group, home, ...}: {
          name = "bootstrap-${name}-systemd";
          value = {
            description = "Mounts ${home}/.config/systemd (Useful for impermanent homes)";
            wantedBy = [ "default.target" ];
            serviceConfig = {
              Type = "oneshot";
              ExecStart = (pkgs.writeShellScript "bootstrap-${name}-systemd" ''
                ${pkgs.coreutils}/bin/mkdir -p "${home}/.config/systemd"
                ${pkgs.coreutils}/bin/chown ${name}:${group} "${home}"
                ${pkgs.coreutils}/bin/chown ${name}:${group} "${home}/.config"
                ${pkgs.coreutils}/bin/mkdir -p "${cfg.persistLocation}/${home}/.config/systemd"
                ${pkgs.coreutils}/bin/chown ${name}:${group} "${cfg.persistLocation}/${home}"
                ${pkgs.coreutils}/bin/chown ${name}:${group} "${cfg.persistLocation}/${home}/.config"
                ${pkgs.util-linux}/bin/mount --bind "${cfg.persistLocation}/${home}/.config/systemd" "${home}/.config/systemd"
              '');
              RemainAfterExit = true;
            };
            # device = "${cfg.persistLocation}/${home}";
            # options = [ "bind" ];
          };
        }
      ) users
    );
  };
}
