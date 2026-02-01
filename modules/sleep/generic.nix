user: { config, name, lib, ... }: {

  imports = [ ];

  options = with lib; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Whether to enable this generic sleep unit.
      '';
    };
    name = mkOption {
      type = types.str;
      default = name;
      description = ''
        Name of the generic sleep unit.
      '';
    };
    path = mkOption {
      type = types.listOf
        (types.either types.package types.string);
      default = [ ];
      description = ''
        Packages added to the PATH of the unit.
      '';
    };
    beforeSleep = mkOption {
      type = types.lines;
      default = "";
      description = ''
        The commands to execute before sleep.
      '';
    };
    afterSleep = mkOption {
      type = types.lines;
      default = "";
      description = ''
        The commands to execute after sleep.
      '';
    };
    before = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        Execute this unit before the ones in the list at sleep.
        And execute it after them when sleep is over.
        Ordering will only apply if units are enabled.
      '';
    };
    after = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        Execute this unit after the ones in the list at sleep.
        And execute it before them when sleep is over.
        Ordering will only apply if units are enabled.
      '';
    };
    description = mkOption {
      type = types.str;
      default = "Generic sleep unit ${name}.";
      description = ''
        One line description of this unit.
      '';
    };
  };
}
