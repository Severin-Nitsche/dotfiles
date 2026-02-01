{ pkgs, ... }: {

  imports = [];

  options = {};

  config = let
    save = "brightnessctl set --save -cleds -d:white:kbd_backlight 0";
    restore = "brightnessctl set --restore -cleds -d:white:kbd_backlight";
  in {

    services.hypridle.enable = true;
    services.hypridle.settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "${save}; loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 420;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
    programs.hyprlock.enable = true;
    programs.hyprlock.settings = {
      "$font" = "SansSerif";
      general.hide_cursor = true;
      general.fail_timeout = 1000;
      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];
      };
      input-field = {
        monitor = "";
        size = "20%, 5%";
        fade_on_empty = false;
        rounding = 15;
        font_family = "$font";
        placeholder_text = "Kennwort eingeben ...";
        fail_text = "falsches Kennwort";
        dots_spacing = 0.3;
        position = "0, -20";
        halign = "center";
        valign = "center";
      };
      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 90;
          font_family = "$font";
          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        {
          monitor = "";
          text = "cmd[update:60000] date +\"%A, %-d. %B %Y\"";
          font_size = 25;
          font_family = "$font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];
    };
  };

}
