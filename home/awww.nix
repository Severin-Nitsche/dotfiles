{ pkgs, ... }: {
  services.awww.enable = true;

  systemd.user.services.wallpaper_randomizer = {
    Unit.Description = "Select a new wallpaper";
    Unit.Requires = "wallpaper_randomizer.timer";
    Unit.After = "awww.service";

    Service = {
      Type = "simple";
      RemainAfterExit = false;
      ExecStart = "${pkgs.wfetch}/bin/wfetch";
    };

    Install.WantedBy = [ "awww.service" ];
  };

  systemd.user.timers.wallpaper_randomizer = {
    Unit.Description = "Timer for the wallpaper service";

    Timer.OnUnitActiveSec = "30min";
  };
}
