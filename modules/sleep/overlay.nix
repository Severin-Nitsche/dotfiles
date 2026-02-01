pkgs:
  pkgs.systemd-lock-handler.overrideAttrs (old: {
    src = pkgs.fetchFromGitHub {
      owner = "Severin-Nitsche";
      repo = "systemd-lock-handler";
      rev = "05db3640ecf1a196ba879d78bd4e49296c511018";
      hash = "sha256-HeW4ePQ1VVyjvvjoGgqI7EfE2MV/z5sa0/0hvIlizT8=";
    };
  })
