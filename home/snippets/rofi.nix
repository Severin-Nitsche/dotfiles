{config, ... }: {
  programs.rofi.enable = true;
  programs.rofi.theme = with config.lib.formats.rasi; {
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

    entry = {
      placeholder = "Suchen...";
    };

    window = {
      border = mkLiteral "0.05em";
      border-radius = mkLiteral "0.5em";
      height = mkLiteral "50%";
    };
  };
}
