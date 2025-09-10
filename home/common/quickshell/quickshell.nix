{ pkgs, quickshell, ... }: {

  imports = [];

  options = {};

  config = {
    
    home.packages = [
      quickshell
    ];

    home.file.".config/quickshell/shell.qml".source = ./shell.qml;

  };

}
