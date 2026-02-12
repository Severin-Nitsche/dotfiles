{
  description = "T2 sleep flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    dbus-systemd-dispatcher.url = "github:Severin-Nitsche/dbus-systemd-dispatcher";
    dbus-systemd-dispatcher.inputs.nixpkgs.follows = "nixpkgs";

    dbus-wait.url = "github:Severin-Nitsche/dbus-wait";
    dbus-wait.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, dbus-systemd-dispatcher, dbus-wait }: {

    nixosModules = rec {
      sleep = (import ./sleep.nix)
        dbus-systemd-dispatcher.nixosModules.default
        dbus-systemd-dispatcher.plugins
        dbus-wait.packages.x86_64-linux.default;
      t2sleep = (import ./t2sleep.nix) sleep;
      default = sleep;
    };

  };
}
