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
        rev = "4805678a705f3fe629fc8bba1574ff83ae96f227";
        hash = "sha256-fLvkmra7wgr0s/AzBLwtjKkCrKI/E/phCRj0okb+CV0=";
      };

      makeFlags = [
        "DESTDIR=$(out)"
        "PREFIX="
      ];

      postPatch = ''
        substituteInPlace 90-brightnessctl.rules \
          --replace-fail /bin/ ${prev.coreutils}/bin/

        substituteInPlace configure \
          --replace-fail "pkg-config" "$PKG_CONFIG"
      '';

      configureFlags = [
        "--enable-logind"
        "--prefix="
      ];

    });
  };

}
