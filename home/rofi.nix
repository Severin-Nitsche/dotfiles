{config, ... }: with config.colors; {
  programs.rofi.enable = true;
  programs.rofi.font = "Route 159 13";
  programs.rofi.theme = with config.lib.formats.rasi; {
    "*" = {
      border-color = mkLiteral white;
      background-color = mkLiteral (black+"00");
      text-color = mkLiteral white;
    };

    element = {
      padding = mkLiteral "0.5em";
      children = map mkLiteral [ "element-icon" "element-text" ];
      spacing = mkLiteral "0.5em";
    };

    element-icon = {
      size =  mkLiteral "1em";
    };

    inputbar = {
      children = map mkLiteral [
        "entry"
        "icon-current-entry"
      ];
      padding = mkLiteral "0.5em";
      border = mkLiteral "0 0 0.05em 0";
    };

    "element selected" = {
      background-color = mkLiteral (argentinian-blue+"90");
    };

    entry = {
      placeholder = "Suchen...";
    };

    window = {
      # border = mkLiteral "0.05em";
      border-radius = mkLiteral "0.5em";
      height = mkLiteral "50%";
      background-color = mkLiteral (afghani-blue+"90");
    };
  };
}
