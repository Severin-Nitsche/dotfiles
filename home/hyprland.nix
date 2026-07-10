{ pkgs, lib, ... }: {

  imports = [
    ./hyprlock.nix # Includes hypridle
    ./quickshell/quickshell.nix
    ./rofi.nix
    ./alacritty.nix
    ./quit.nix
  ];

  options = {};

  config = {
    home.packages = with pkgs; [ 
      brightnessctl
      pamixer
      playerctl
      grimblast # Screenshots

      kdePackages.dolphin
      udiskie
      runapp
      hyprshutdown

      kdePackages.qtwayland # qt6
      qt5.qtwayland # qt5
      nerd-fonts.symbols-only # Icons
      route159 # NixOS font
      dunst
    ];

    # Automagical brightness adjustment
    services.wluma.enable = true;

    fonts.fontconfig.enable = true; # Icons

    # Manage Keyboard Layouts
    xdg.configFile."xkb".source = ./xkb;
    xdg.configFile."xkb".recursive = true;

    # Manage file explorer
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["org.gnome.Nautilus.desktop"];
        "inode/mount-point" = ["org.gnome.Nautilus.desktop"];
        "application/pdf" = ["librewolf.desktop"];
      };
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];

    xdg.portal.config = {
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [
          "dolphin"
        ];
      };
    };

    # Miscellaneous
    services.hyprpolkitagent.enable = true;
    programs.alacritty.enable = true;

    # Manage Hyprland
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.configType = "lua";
    hyprconf = let
      mod = "CTRL";
      alt = "MOD5";
      lmb = "mouse:272";
      rmb = "mouse:273";
      mmb = "mouse:274";
      runner = "runapp";
      logout = "hyprshutdown";
    in {
      env = [
        [ "GDK_BACKEND" "wayland,x11" ]
        [ "QT_QPA_PLATFORM" "wayland;xcb" ]
        [ "SDL_VIDEODRIVER" "wayland" ]
        [ "CLUTTER_BACKEND" "wayland" ]
        [ "NIXOS_OZONE_WL" "1" ]
        [ "ANKI_WAYLAND" "1" ]
      ];
      bind = [
        {
          keys = "${alt} + ${lmb}";
          "window.drag" = [];
          flags.mouse = true;
        }
        {
          keys = "mouse:276";
          focus.workspace = "r+1";
          flags.mouse = true;
        }
        {
          keys = "mouse:275";
          focus.workspace = "r-1";
          flags.mouse = true;
        }
        {
          keys = "${mod} + Q";
          "window.close" = "activewindow";
        }
        {
          keys = "${mod} + return";
          exec_cmd = "${runner} alacritty";
        }
        {
          keys = "${mod} + ${alt} + BackSpace";
          exec_cmd = logout;
        }
        {
          keys = "${mod} + space";
          exec_cmd =
            "rofi -show drun -run-command '${runner} {cmd}'";
        }
        {
          keys = "${mod} + tab";
          exec_cmd = "rofi -show";
        }
        {
          keys = "${mod} + E";
          exec_cmd = [
            "${runner} dolphin"
            { 
              float = true; 
              size = ["monitor_w * 0.5" "monitor_h * 0.5"];
            }
          ];
        }
        {
          keys = "${mod} + L";
          exec_cmd = "hyprlock";
        }
        {
          keys = "${mod} + 1";
          "window.fullscreen".mode = "maximized";
        }
        {
          keys = "${mod} + 2";
          "window.fullscreen".mode = "fullscreen";
        }
        {
          keys = "${mod} + 3";
          "window.float".action = "toggle";
        }
        {
          keys = "${mod} + SHIFT + 4";
          exec_cmd = "grimblast copy area";
        }
        {
          keys = "XF86KbdBrightnessDown";
          exec_cmd = 
            "brightnessctl set -c leds -d :white:kbd_backlight -e 20%-";
          flags = { repeating = true; locked = true; };
        }
        {
          keys = "XF86KbdBrightnessUp";
          exec_cmd = 
            "brightnessctl set -c leds -d :white:kbd_backlight -e +20%";
          flags = { repeating = true; locked = true; };
        }
        {
          keys = "XF86MonBrightnessDown";
          exec_cmd = 
            "brightnessctl set -c backlight -d intel_backlight -e 4%-";
          flags = { repeating = true; locked = true; };
        }
        {
          keys = "XF86MonBrightnessUp";
          exec_cmd = 
            "brightnessctl set -c backlight -d intel_backlight -e +4%";
          flags = { repeating = true; locked = true; };
        }
        {
          keys = "XF86AudioLowerVolume";
          global = "quickshell:volumeDown";
          flags = { repeating = true; locked = true; };
        }
        {
          keys = "XF86AudioRaiseVolume";
          global = "quickshell:volumeUp";
          flags = { repeating = true; locked = true; };
        }
        {
          keys = "XF86AudioMute";
          global = "quickshell:deafen";
          flags.locked = true;
        }
        {
          keys = "XF86AudioPrev";
          exec_cmd = "playerctl previous";
          flags.locked = true;
        }
        {
          keys = "XF86AudioPlay";
          exec_cmd = "playerctl play-pause";
          flags.locked = true;
        }
        {
          keys = "XF86AudioNext";
          exec_cmd = "playerctl next";
          flags.locked = true;
        }
        {
          keys = "${mod} + ISO_Level3_Shift";
          config.general.gaps_out = 40;
          # stolen from https://github.com/Sijan-Bhusal/HyprShades
          # config.decoration.screen_shader = ./shader.frag;
          submap = "layout";
        }
      ];
      submaps.layout.bind = [
        {
          keys = "space";
          layout = "togglesplit";
        }
        {
          keys = "S";
          layout = "swapsplit";
        }
        {
          keys = "catchall";
          submap = "reset";
          config.general.gaps_out = 20;
          config.decoration.screen_shader = "";
        }
      ];

      layer_rule = [
        {
          match.namespace = "quickshell";
          blur = true;
        }

        {
          match.namespace = "rofi";
          blur = true;
          ignore_alpha = 0.3;
        }
      ];

      on = [[
        "hyprland.start"
        (lib.generators.mkLuaInline ''
          function ()
            hl.exec_cmd("${runner} quickshell")
            hl.exec_cmd("udiskie")
          end
        '')
      ]];

      device = [
        {
          name = "ergo-k860-keyboard";
          kb_options = "power:caps,mac:k860";
        }
      ];

      gesture = [
        {
          fingers = 3;
          direction = "horizontal";
          action = "workspace";
        }
        {
          fingers = 4;
          direction = "horizontal";
          action = "workspace";
        }
      ];

      config = {
        input = {
          resolve_binds_by_sym = true;
          kb_layout = "de,math";
          kb_variant = "mac,lvl5";
          kb_options = "power:caps,power:alt3,altwin:ctrl_win";
          kb_rules = "evdev";
          touchpad = {
            disable_while_typing = true;
            natural_scroll = true;
            clickfinger_behavior = true;
            scroll_factor = 0.8;
          };
        };
        gestures = {
          workspace_swipe_min_speed_to_force = 15;
          workspace_swipe_cancel_ratio = 0.05;
        };
        decoration = {
          rounding = 5;
          rounding_power = 4.0;
          blur = {
            size = 8;
            passes = 2;
          };
        };
        general = {
          resize_on_border = true;
          hover_icon_on_border = true;
        };
        dwindle.preserve_split = true;
      };
    };
  };

}
