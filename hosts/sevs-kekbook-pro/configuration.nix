# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../snippets/impermanence.nix
      ../snippets/printNscan.nix
      ../snippets/bluetooth.nix
      ../snippets/localization_de_mac.nix
      ../snippets/hyprland.nix
      ../snippets/suspend.nix
    ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Networking (nmtui instead of wpa_cli)
  networking.hostName = "sevs-kekbook-pro";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Enable sddm as display/login manager
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
  };

  # Define a user account.
  users.mutableUsers = true;

  users.users.root = {
    isSystemUser = true;
    initialPassword = "";
  };

  users.users.severin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "";
    createHome = true;
    packages = with pkgs; [
      home-manager
    ];
  };

  # Packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  programs.steam.enable = true;

  # Do not change
  system.stateVersion = "24.11";

}

