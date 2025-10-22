{ pkgs, quickshell, ... }: {

  imports = [];

  options = {};

  config = {
    
    home.packages = [
      quickshell
    ];

    home.file.".config/quickshell/" = {
     source = ./config;
     recursive = true;
    };

  };

}
