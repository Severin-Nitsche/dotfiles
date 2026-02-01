{ pkgs, lib, config, ... }: 
let cfg = config.t2sleep; in {

  imports = [
    ./sleep.nix
  ];

  options.t2sleep = with lib; {
    enable = mkEnableOption "T2 sleep fixes";

    reloadTouchbar = mkOption {
      type = types.bool;
      default = cfg.reloadTinyDFR;
      description = "Try reload the touchbar.";
    };

    reloadTinyDFR = mkOption {
      type = types.bool;
      default = false;
      description = "Try reload tiny-dfr (for customizable touchbar).";
    };

    reloadWiFi = mkOption {
      type = types.bool;
      default = false;
      description = "Try reload WiFi.";
    };

    wifi.device = mkOption {
      type = types.str;
      default = "wifi";
      description = "The pci wifi device.";
    };

    wifi.hot-reset = mkOption {
      type = types.bool;
      default = cfg.wifi.device != "wifi";
      description = "Whether to hot reset the wifi device.";
    };

    reloadWireplumber = mkOption {
      type = types.bool;
      default = config.services.pipewire.wireplumber.enable;
      description = "Try reload audio.";
    };
  };

  config = lib.mkIf cfg.enable {

    sleep.reset.t2hardware = {
      drivers = [
        { driver = "apple_bce"; force = true; }
      ];
    };

    sleep.reset.wifi = {
      enable = cfg.reloadWiFi;
      device = cfg.wifi.device;
      hot-reset = cfg.wifi.hot-reset;
      defer = true;
      drivers = [ "brcmfmac" "brcmfmac_wcc" ];
      after = [ "t2hardware" ];
    };

    sleep.reset.tinyDFR = {
      enable = cfg.reloadTinyDFR;
      drivers = [
        "appletbdrm"
        {
          packages = [ pkgs.tiny-dfr ];
          remove = "tiny-dfr stop";
          insert = "tiny-dfr start";
        }
      ];
      before = [ "t2hardware" ];
      after = [ "touchbar" ];
    };

    sleep.reset.touchbar = {
      enable = cfg.reloadTouchbar;
      drivers = [ "hid_appletb_bl" "hid_appletb_kbd" ];
      before = [ "t2hardware" ];
    };

    sleep.user.enable = cfg.reloadWireplumber;
    sleep.user.exclude = [ "wireplumber.service" ];

    # boot.kernelPatches = [ {
    #   name = "force-unload";
    #   patch = null;
    #   extraConfig = "MODULE_FORCE_UNLOAD y";
    # } ];
  };
}
