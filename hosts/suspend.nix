{
  # Fix suspend
  systemd.sleep.settings.Sleep.SuspendState = "mem";

  t2sleep.enable = true;
  t2sleep.reloadTouchbar = true;
  t2sleep.reloadWiFi = true;
  t2sleep.restoreBrightness = true;
}
