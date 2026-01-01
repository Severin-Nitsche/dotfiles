{ pkgs, ... }: {

  imports = [
    ./hyprlock/hyprlock.nix # Includes hypridle
    ./quickshell/quickshell.nix
    ./rofi.nix
  ];

  options = {};

  config = {
    home.packages = with pkgs; [ 
      brightnessctl
      pamixer
      playerctl
      grimblast # Screenshots

      nautilus

      kdePackages.qtwayland # qt6
      libsForQt5.qt5.qtwayland # qt5
      nerd-fonts.symbols-only # Icons
      route159 # NixOS font
      dunst
    ];

    fonts.fontconfig.enable = true; # Icons

    # Manage uwsm session variables (force Wayland)
    xdg.configFile."uwsm/env".text = ''
      export GDK_BACKEND=wayland,x11,*
      export QT_QPA_PLATFORM="wayland;xcb"
      export SDL_VIDEODRIVER=wayland
      export CLUTTER_BACKEND=wayland
      export NIXOS_OZONE_WL=1
    '';

    # Manage Keyboard Layouts
    xdg.configFile."xkb".source = ./xkb;
    xdg.configFile."xkb".recursive = true;

    # Manage file explorer
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["org.gnome.Nautilus.desktop"];
        "inode/mount-point" = ["org.gnome.Nautilus.desktop"];
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
          "nautilus"
        ];
      };
    };

    # Manage Hyprland
    wayland.windowManager.hyprland.enable = true;
    services.hyprpolkitagent.enable = true;
    programs.alacritty.enable = true;
    wayland.windowManager.hyprland.settings = {
      "$mod" = "CTRL";
      "$alt" = "Mod5";
      "$lmb" = "mouse:272";
      "$rmb" = "mouse:273";
      "$mmb" = "mouse:274";
      bindm = [
        "$alt, $lmb, movewindow"
      ];
      bind = [
        ", mouse:276, workspace, r+1"
        ", mouse:275, workspace, r-1"
        "$mod, Q, killactive"
        "$mod, return, exec, uwsm app -- alacritty"
        "$mod, M, exec, uwsm stop" # Do not use exit with uwsm
        "$mod, space, exec, uwsm app -- rofi -show drun -run-command 'uwsm app -- {cmd}'"
        "$mod, E, exec, [float] uwsm app -- nautilus"
        "$mod, L, exec, hyprlock"
        "$mod, 1, fullscreen, 0"
        "$mod, 2, fullscreen, 1"
        "$mod, 3, togglefloating, active"
        "$mod, J, togglesplit, active"
        "$mod, K, swapsplit, active"
        "$mod Shift, 4, exec, grimblast copy area"
      ];
      bindel = [
        ", XF86KbdBrightnessDown, exec, brightnessctl set -c leds -d :white:kbd_backlight -e 20%-"
        ", XF86KbdBrightnessUp, exec, brightnessctl set -c leds -d :white:kbd_backlight -e +20%"
        ", XF86MonBrightnessDown, exec, brightnessctl set -c backlight -d intel_backlight -e 4%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set -c backlight -d intel_backlight -e +4%"
        ", XF86AudioLowerVolume, exec, pamixer --decrease 4"
        ", XF86AudioRaiseVolume, exec, pamixer --increase 4"
      ];
      bindl = [
        ", XF86AudioMute, exec, pamixer --toggle-mute"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
      ];

      layerrule = [
        "blur, quickshell"
      ];

      exec-once = [
        "uwsm app -- quickshell"
      ];
      
      input = {
        kb_layout = "de";
        kb_variant = "mac";
        kb_options = "power:caps,lv3:alt_switch,altwin:ctrl_win";
        kb_rules = "evdev";
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          clickfinger_behavior = true;
          scroll_factor = 0.8;
        };
      };
      device = [
        {
          name = "ergo-k860-keyboard";
          kb_options = "power:caps,mac:k860";
        }
      ];
      gesture = [
        "3, horizontal, workspace"
        "4, horizontal, workspace"
      ];
      gestures = {
        workspace_swipe_min_speed_to_force = 15;
        workspace_swipe_cancel_ratio = 0.05;
      };
      decoration = {
        rounding = 5;
        rounding_power = 4.0;
      };
      general = {
        resize_on_border = true;
      };
      dwindle = {
        preserve_split = true;
      };
    };
    wayland.windowManager.hyprland.systemd.enable = false; # uwsm compatibility
  };

}
