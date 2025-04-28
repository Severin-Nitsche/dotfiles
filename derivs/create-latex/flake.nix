{
  description = "Create LaTeX flake";

  inputs = {
    create-latex.url = "git+ssh://git@github.com/Severin-Nitsche/Create-Latex.git";
    create-latex.flake = false;

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, create-latex }: 
  let
    pkgs = nixpkgs.legacyPackages.x86_64-darwin; 
  in {
    legacyPackages.x86_64-darwin.default = pkgs.stdenv.mkDerivation (finalAttrs: {
      pname = "tex";
      version = create-latex.rev;

      src = create-latex;

      buildInputs = [
        pkgs.dotnetCorePackages.sdk_9_0_1xx 
      ];

      buildPhase = ''
        ls -R $PWD/nix-packages
        export NUGET_PACKAGES=$PWD/nix-packages
        dotnet publish -c Release -r osx-x64 --sc true --no-restore --packages $NUGET_PACKAGES
      '';

      installPhase = ''
        mkdir -p $out/bin
        cp -r bin/Release/net7.0/osx-x64/ $out/bin
      '';

      meta = {
        description = "Create LaTeX";
        homepage = "https://github.com/Severin-Nitsche/Create-Latex/";
      };
    });
  };
}
