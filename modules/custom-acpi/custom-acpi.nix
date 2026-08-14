{ lib, config, pkgs, ... }: {

  options.boot.initrd.custom-acpi = lib.mkOption {
    type = lib.types.listOf lib.types.path;
    default = [];
    description = ''
      Compile these custom acpi files and add them to the initrd
    '';
  };

  config = {
    boot.initrd.prepend = lib.map (
      dsl: let
        baseName = lib.baseNameOf dsl;
      in "${(pkgs.callPackage ({ stdenv, acpica-tools, cpio}: stdenv.mkDerivation {
        name = "ACPI-${baseName}";
        src = dsl;

        phases = [ "installPhase" ];

        nativeBuildInputs = [
          acpica-tools
          cpio
        ];

        installPhase = ''
          mkdir -p $out/
          mkdir -p kernel/firmware/acpi

          iasl -p ./kernel/firmware/acpi/${baseName} -tc $src

          find kernel | cpio -H newc --create > $out/acpi-${baseName}.cpio
        '';
      }) {})}/acpi-${baseName}.cpio"
    ) config.boot.initrd.custom-acpi;
  };

}
