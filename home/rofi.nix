{config, ... }: {
  programs.rofi.enable = true;
  programs.rofi.font = "Route 159 13";
  programs.rofi.theme = with config.lib.formats.rasi; {
    "*" = {
      border-color = mkLiteral "White";
      background-color = mkLiteral "rgba(0,0,0,0%)";
      text-color = mkLiteral "White";
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
      background-color = mkLiteral "rgba(0,100,200,50%)";
    };

    entry = {
      placeholder = "Suchen...";
    };

    window = {
      # border = mkLiteral "0.05em";
      border-radius = mkLiteral "0.5em";
      height = mkLiteral "50%";
      background-color = mkLiteral "rgba(0,50,100,50%)";
    };
  };
}
