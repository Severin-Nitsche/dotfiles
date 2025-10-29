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
        rev = "8b071f623ff4d59de9f83de0df0ad4f615b7963e";
        hash = "sha256-pjh2n412ykqxm7iEiHLJHCj1DltQOttwbxg3FLnJvJs=";
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
