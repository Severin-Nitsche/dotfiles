{ pkgs, ... }: {
  # Printing & Scanning
  hardware.sane.enable = true;
  hardware.sane.extraBackends = with pkgs; [
    sane-airscan
  ];
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    gutenprint
  ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
