pkgs: { config, lib, ... }: {

  imports = [ ];

  options = with lib; {
    driver = mkOption {
      type = types.str;
      default = "";
      description = ''
        The name of the driver to reload.
      '';
    };

    force = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to eject this driver forcefully.
      '';
    };

    packages = mkOption {
      type = types.listOf types.package;
      default = [ pkgs.kmod ];
      description = ''
        The packages to eject / insert the driver.
      '';
    };

    remove = mkOption {
      type = types.lines;
      default = if config.force then
        "rmmod -f ${config.driver}"
      else
        "modprobe -r ${config.driver}"
      ;
      description = ''
        The command to remove the driver.
      '';
    };

    insert = mkOption {
      type = types.lines;
      default = "modprobe ${config.driver}";
      description = ''
        The command to insert the driver
      '';
    };

  };
}
