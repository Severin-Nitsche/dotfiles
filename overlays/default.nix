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
        rev = "2cb0b48a4c3095d119c5dd918a64cfe356958d23";
        hash = "sha256-GTrkZzZBgObSStBeWgOSJSL2gq5iyWluOnLHj6v8ppQ=";
      };

      makeFlags = [
        "PREFIX="
        "DESTDIR=$(out)"
        "ENABLE_LOGIND=1"
      ];
    });
  };

}
