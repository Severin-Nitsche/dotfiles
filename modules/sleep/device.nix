pkgs: { config, name, lib, ... }: {

  imports = [ ];

  options = with lib; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to reload this device.

        Note that this is a special kind of generic unit.
      '';
    };

    hot-reset = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to hot reset this device.
      '';
    };

    name = mkOption {
      type = types.str;
      default = name;
      description = ''
        Name of this unit.

        Use this to refer to this action in ordering relations.
      '';
    };

    device = mkOption {
      type = types.str;
      default = name;
      description = ''
        Name of the pci device.
        This is only relevant if `hot-reset` is `true`.
      '';
    };

    defer = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Defer the unloading of this device's drivers until resume.

        This can be useful when there is another driver that tries to manage the device if these drivers are not present. In those cases, it can happen that the other driver puts the device into a state where this driver cannot recover from even after reloading. (Compare pci vs. brcmfmac race condition)
      '';
    };

    noBarrier = mkOption {
      type = types.bool;
      default = false;
      description = ''
        If barriers are enabled and this option is set, the device will be reset regardless of barrier state. Default is to reset only after the userbarrier is reached.
      '';
    };

    drivers = mkOption {
      type = types.listOf
        (types.coercedTo types.str (d: {driver = d;}) (types.submodule ((import ./driver.nix) pkgs)));
      default = [ ];
      description = ''
        The drivers for the device.
        The order determines the loading order of the drivers.

        Set `{ driver = "foo"; force = true; }` if foo is to be ejected forcefully.
      '';
    };

    before = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        Reload this device before the ones in the list *after* sleep.
      '';
    };

    after = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        Reload this device after the ones in the list *after* sleep.
      '';
    };
  };
}
