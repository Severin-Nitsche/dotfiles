{

  additions = final: prev: { # Additional Packages
    vpn-rbw = prev.callPackage ../derivs/vpn-rbw/vpn-rbw.nix {};
    fixLaunchpad = prev.callPackage ../derivs/fixLaunchpad/fixLaunchpad.nix {};
  };

  modifications = final: prev: { # Modified Packages

  };

}
