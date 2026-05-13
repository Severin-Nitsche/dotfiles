{ pkgs, ... }: {
  home.shellAliases = {
    exit = "${pkgs.quit}/bin/quit fail";

    ":q!" = "${pkgs.quit}/bin/quit normal";

    ":q" = "\\exit";

    ":qa" = "${pkgs.quit}/bin/quit all";

    ":qa!" = "${pkgs.quit}/bin/quit force";
  };
}
