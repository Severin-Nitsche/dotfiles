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
        rev = "0916a2930306407d6d48d3256fcbc649ab306205";
        hash = "sha256-tn3Fne5TaEUflZBh847wB9lkzQjvJjRp16KCg7timsw=";
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
