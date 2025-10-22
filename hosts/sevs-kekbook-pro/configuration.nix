# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../snippets/impermanence.nix
    ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "sevs-kekbook-pro"; # Define your hostname.

  # Networking
  networking.networkmanager.enable = true;  # Easier than wpa_cli

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Name = "sevs-kekbook-pro";
    };
  };

  # Printing
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    gutenprint
  ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  # console.keyMap = "de";
  console.useXkbConfig = true;

  # Enable sddm as display/login manager
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Enable Upower
  services.upower.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "de";
  services.xserver.xkb.variant = "mac";
  # services.xserver.xkb.options = "lv3:alt_switch"; # Switching to ttyX impossible (ctrl+lalt+FX)

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = true;

  users.users.root = {
    isSystemUser = true;
    initialPassword = "";
  };
  # security.sudo.enable = true;
  users.users.severin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "";
    createHome = true;
    linger = true; # This is needed for impermanence so that our user services run at boot
    packages = with pkgs; [
      home-manager
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  programs.steam.enable = true; # I hate that this is not working at user site

  # Enable HYPRLAND
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  security.pam.services.hyprlock.enable = true;

  # Fix suspend
  systemd.sleep.extraConfig = ''
    SuspendState=freeze
  '';

  # Fix touchbar disappearing after resume
  powerManagement.resumeCommands = ''
    echo "Fixing touchbar by reloading kernel modules"
    /run/current-system/sw/bin/modprobe -r hid_appletb_bl
    /run/current-system/sw/bin/modprobe -r hid_appletb_kbd
    /run/current-system/sw/bin/modprobe -r appletbdrm
    /run/current-system/sw/bin/modprobe hid_appletb_bl
    /run/current-system/sw/bin/modprobe hid_appletb_kbd
    /run/current-system/sw/bin/modprobe appletbdrm
  '';

  services.dbus.implementation = "broker"; # Recommended for uwsm

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "24.11"; # Do not change

}

