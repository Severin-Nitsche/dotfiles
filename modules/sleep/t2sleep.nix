sleep: { pkgs, lib, config, ... }:
let cfg = config.t2sleep; in {

  imports = [
    sleep
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

    restoreBrightness = mkOption {
      type = types.bool;
      default = false;
      description = "Enable brightness restoration";
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

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      sleep.enable = true;
      sleep.reset.t2hardware = {
        drivers = [
          { driver = "apple_bce"; force = true; }
        ];
      };
    }
    (lib.mkIf cfg.reloadWiFi {
      sleep.reset.wifi = {
        enable = cfg.reloadWiFi;
        device = cfg.wifi.device;
        hot-reset = cfg.wifi.hot-reset;
        defer = true;
        drivers = [ "brcmfmac" "brcmfmac_wcc" ];
        after = [ "t2hardware" ];
      };
    })
    (lib.mkIf cfg.reloadTinyDFR {
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
        after = if cfg.relaodTouchbar then
          [ "touchbar" ]
        else [];
      };
    })
    (lib.mkIf cfg.reloadTouchbar {
      sleep.reset.touchbar = {
        enable = cfg.reloadTouchbar;
        drivers = [ "hid_appletb_bl" "hid_appletb_kbd" ];
        before = [ "t2hardware" ];
      };
    })
    (lib.mkIf cfg.reloadWireplumber {
      sleep.user.enable = true;
      sleep.user.exclude = [ "wireplumber.service" ];
    })
    (lib.mkIf cfg.restoreBrightness {
      sleep.user.enable = true;

      sleep.generic.backlightsOff = {
        description = "Sleep Backlight Switch";
        beforeSleep = ''
          echo 0 > /sys/class/leds/\:white\:kbd_backlight/brightness
          echo 0 > /sys/class/backlight/appletb_backlight/brightness
        '';
        passthru.conflicts = [
          "systemd-backlight@leds::white:kbd_backlight.service"
          "systemd-backlight@backlight:appltetb_backlight.service"
        ];
        passthru.serviceConfig.RemainAfterExit = "false";
        after = [
          "systemd-backlight@leds::white:kbd_backlight"
          "systemd-backlight@backlight:appltetb_backlight"
        ]; 
        before = [ "t2hardware" ];
      };
    })
  ]);
}
