{ pkgs, ... }: {

  imports = [];

  options = {};

  config = {

    services.hypridle.enable = true;
    services.hypridle.settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 420;
          on-timeout = "hyprctl dispatch dpms off && brightnessctl set --save -cleds -d:white:kbd_backlight 0";
          on-resume = "hyprctl dispatch dpms on && brightnessctl set --restore -cleds -d:white:kbd_backlight";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
    programs.hyprlock.enable = true;
    home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;

  };

}
