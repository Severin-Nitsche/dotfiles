{ pkgs, lib, config, ... }: {
  options = let
    mkPersistOpt = file: def: lib.mkOption {
      type = lib.types.bool;
      default = def;
      description = "Whether to preserve ${file}.";
    };
  in {
    shadowHack.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable the persist shadow hack.";
    };
    shadowHack.persistLocation = lib.mkOption {
      type = lib.types.path;
      description = "Where to persist the shadow.";
    };
    shadowHack.persist = {
      loginDefs = mkPersistOpt "/etc/login.defs" false;
      group = mkPersistOpt "/etc/group" true;
      passwd = mkPersistOpt "/etc/passwd" true;
      shadow = mkPersistOpt "/etc/shadow" true;
      subuid = mkPersistOpt "/etc/subuid" true;
      subgid = mkPersistOpt "/etc/subgid" true;
      gshadow = mkPersistOpt "/etc/gshadow" true;
    };
  };

  config = let 
    cfg = config.shadowHack;
    copy = file: ''
      echo shadowHack enabled for ${file}
      [ -f ${file} ] && cp --update=none ${file} "${cfg.persistLocation}/${file}" || echo ${file} does not exist
      [ -f "${cfg.persistLocation}/${file}" ] && cp "${cfg.persistLocation}/${file}" ${file} || echo ${cfg.persistLocation}/${file} does not exist
    '';
    copyCmd = file: opt: if opt then copy file else "echo shadowHack disabled for ${file}";
    save = file: ''
      cp ${file} "${cfg.persistLocation}/${file}"
    '';
    saveCmd = file: opt: if opt then save file else "";
    sysd = name: file: opt: {
      enable = opt;
      description = "Persist ${file}";
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.util-linux ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = pkgs.writeShellScript name ''
          mkdir -p "${cfg.persistLocation}/etc"
          ${saveCmd file opt}
        '';
      };
    };
  in lib.mkIf cfg.enable { # Inspired by https://github.com/nix-community/impermanence/issues/120#issuecomment-2382674299
    system.activationScripts.shadowHack.text = ''
      ${copyCmd "/etc/login.defs" cfg.persist.loginDefs}
      ${copyCmd "/etc/group" cfg.persist.group}
      ${copyCmd "/etc/passwd" cfg.persist.passwd}
      ${copyCmd "/etc/shadow" cfg.persist.shadow}
      ${copyCmd "/etc/subuid" cfg.persist.subuid}
      ${copyCmd "/etc/subgid" cfg.persist.subgid}
      ${copyCmd "/etc/gshadow" cfg.persist.gshadow}
    '';
    system.activationScripts.users.deps = [ "shadowHack" ];

    systemd.services.shadowHackShutdownLogin = sysd "shadowHackShutdownLogin" "/etc/login.defs" cfg.persist.loginDefs;
    systemd.services.shadowHackShutdownGroup = sysd "shadowHackShutdownGroup" "/etc/group" cfg.persist.group;
    systemd.services.shadowHackShutdownPasswd = sysd "shadowHackShutdownPasswd" "/etc/passwd" cfg.persist.passwd;
    systemd.services.shadowHackShutdownShadow = sysd "shadowHackShutdownShadow" "/etc/shadow" cfg.persist.shadow;
    systemd.services.shadowHackShutdownSubuid = sysd "shadowHackShutdownSubuid" "/etc/subuid" cfg.persist.subuid;
    systemd.services.shadowHackShutdownSubgid = sysd "shadowHackShutdownSubgid" "/etc/subgid" cfg.persist.subgid;
    systemd.services.shadowHackShutdownGshadow = sysd "shadowHackShutdownGshadow" "/etc/gshadow" cfg.persist.gshadow;
  };

}
