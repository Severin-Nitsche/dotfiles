{
  description = "Lucide Icons on demand and in color";

  inputs = {
    lucide.url = "github:lucide-icons/lucide";
    lucide.flake = false;
  };

  outputs = { self, lucide }: {

    homeManagerModules.default = (import ./lucide.nix) lucide;

  };
}
