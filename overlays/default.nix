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
        rev = "8a0bb4ee10caf335e6a6108ac28b1b43b82dca83";
        hash = "sha256-55FKtfpukTd8CbBZvdL+2yB8JFqwAEoHigMp0qnlwJY=";
      };

      makeFlags = [
        "PREFIX="
        "DESTDIR=$(out)"
        "ENABLE_LOGIND=1"
      ];
    });
  };

}
