{ pkgs, ... }: {

  programs.vesktop.enable = true;
  programs.vesktop.settings = {
    discordBranch = "stable";
    minimizeToTray = true;
    arRPC = false;
    splashColor = "rgb(239, 239, 240)";
    splashBackground = "rgb(32, 32, 36)";
  };
  programs.vesktop.vencord.settings = {
    autoUpdate = false;
    autoUpdateNotification = false;
    notifyAboutUpdates = false;
    useQuickCss = true;
    plugins = {
      AlwaysTrust.enabled = true;
      # AnonymiseFileNames.enabled = true;
      BiggerStreamPreview.enabled = true;
      ClearURLs.enabled = true;
      CopyFileContents.enabled = true;
      FakeNitro.enabled = true;
      FakeProfileThemes.enabled = true;
      IrcColors.enabled = true;
      IrcColors.lightness = 25;
      MemberCount.enabled = true;
      SilentTyping.enabled = true;
      SpotifyControls.enabled = true;
      SpotifyCrack.enabled = true;
      SpotifyShareCommands.enabled = true;
      VoiceDownload.enabled = true;
      VoiceMessages.enabled = true;
      YoutubeAdblock.enabled = true;
    };
  };
}
