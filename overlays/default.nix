{

  additions = final: prev: { # Additional Packages
    vpn-rbw = prev.callPackage ../derivs/vpn-rbw/vpn-rbw.nix {};
    fixLaunchpad = prev.callPackage ../derivs/fixLaunchpad/fixLaunchpad.nix {};
  };

  modifications = final: prev: { # Modified Packages
    brightnessctl = prev.brightnessctl.overrideAttrs (old: {
      version = "0.6";
      src = prev.fetchFromGitHub {
        owner = "Severin-Nitsche";
        repo = "brightnessctl";
        rev = "870b084cc441c278f369a5de86b77068e37d21cd";
        hash = "sha256-RDCDRdyqyP0/8xWzrBTxMCvIaEFU3R8OSttzwloKKKI=";
      };

      makeFlags = [
        "PREFIX="
        "DESTDIR=$(out)"
        "ENABLE_LOGIND=1"
      ];
    });
  };

}
