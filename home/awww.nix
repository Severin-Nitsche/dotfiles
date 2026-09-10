{ pkgs, ... }: {
  services.awww.enable = true;

  systemd.user.services.wallpaper_fetch = {
    Unit.Description = "Fetch a new wallpaper from source splash";
    Unit.Requires = "wallpaper_fetch.timer";
    Unit.After = "awww.service";

    Service = {
      Type = "simple";
      RemainAfterExit = false;
      ExecStart = "${pkgs.wfetch}/bin/wfetch";
    };

    Install.WantedBy = [ "awww.service" ];
  };

  systemd.user.timers.wallpaper_fetch = {
    Unit.Description = "Timer for the wallpaper fetch service";

    Timer.OnUnitActiveSec = "30min";
  };
}
