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
        rev = "65fdb2d0835690aa7ee182e13990dcf3b5c6c880";
        hash = "sha256-3ReCw+FdYMDlnVYkiohBOOY96EU2MmsAHxt5RK78gSg=";
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
