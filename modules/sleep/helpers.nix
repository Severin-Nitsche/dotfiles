cfg: lib: rec {
  mkUnit = _: generic: lib.recursiveUpdate {
    enable = generic.enable;
    description = generic.description;
    name = generic.name + ".service";
    wantedBy = [ "sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
    };
    unitConfig = {
      StopWhenUnneeded = "yes";
      DefaultDependencies = "no";
    };
    path = generic.path;
    script = generic.beforeSleep;
    preStop = generic.afterSleep;
    before = [ "sleep.target" ] ++
      builtins.map (x: x + ".service") generic.before;
    after = builtins.map (x: x + ".service") generic.after;
  } generic.passthru;

  mkGeneric = _: device: let
    drivers = builtins.concatMap
      (driver: driver.packages) device.drivers;
    insert = lib.concatMapStringsSep
      "\n" (driver: driver.insert) device.drivers;
    remove = lib.concatMapStringsSep 
      "\n" (driver: driver.remove) (lib.reverseList device.drivers);
    reload = if device.hot-reset then
      "hot-reset ${device.device}\n${insert}" 
    else insert;
  in {
    enable = device.enable;
    description = "Device/Driver reset for ${device.device}";
    name = device.name;
    before = device.after;
    after = if !device.noBarrier && cfg.user.barriers && cfg.user.enable then
      [ "userbarrier" ] ++ device.before
    else device.before;
    path = if device.hot-reset then
      [ cfg.hot-reset.package ] ++ drivers
    else drivers;
    afterSleep = if device.defer then
      "${remove}\n${reload}"
    else reload;
    beforeSleep = if device.defer then "" else remove;
  };

  sync = rsig: ssig: receiver: sender: ''
    dbus-wait \
    path ${sender} \
    interface systemd.signal \
    member ${rsig} -- \
    \
    dbus-send --system \
    ${receiver} \
    systemd.signal.${ssig}

    dbus-send --system \
    ${receiver} \
    systemd.signal.${ssig}
  '';
  sender = sender: receiver:
    sync "stop" "stopped" receiver sender;
  receiver = receiver: sender:
    sync "stopped" "stop" sender receiver;
}
