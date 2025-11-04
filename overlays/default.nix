{

  additions = final: prev: { # Additional Packages
    vpn-rbw = prev.callPackage ../derivs/vpn-rbw/vpn-rbw.nix {};
    fixLaunchpad = prev.callPackage ../derivs/fixLaunchpad/fixLaunchpad.nix {};
  };

  modifications = final: prev: { # Modified Packages
    nautilus = prev.nautilus.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        mkdir -p $out/share/xdg-desktop-portal/portals
        cat > $out/share/xdg-desktop-portal/portals/nautilus.portal <<EOF
        [portal]
        DBusName=org.gnome.Nautilus
        Interfaces=org.freedesktop.impl.portal.FileChooser
        EOF
      '';
    });
    brightnessctl = prev.brightnessctl.overrideAttrs (old: {
      version = "0.6";
      src = prev.fetchFromGitHub {
        owner = "Severin-Nitsche";
        repo = "brightnessctl";
        rev = "2e6484bbbca897400ec3a5968741848e8025bc86";
        hash = "sha256-Do/rXojbn1OS+7euiKvWHVl6iIUILBsTgOWTICEak40=";
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
