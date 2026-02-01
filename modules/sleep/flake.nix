{
  description = "T2 sleep flake";

  inputs = {};

  outputs = { self }: {

    nixosModules = rec {
      sleep = ./sleep.nix;
      t2sleep = ./t2sleep.nix;
      default = sleep;
    };

  };
}
