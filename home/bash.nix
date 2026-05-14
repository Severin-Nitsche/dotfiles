{ pkgs, ... }: {
  programs.bash.bashrcExtra = ''
    PROMPT_COMMAND='PS1_CMD1=$(echo $PATH | tr '"'"':'"'"' '"'"'\n'"'"' | sed -n '"'"'/\/nix\/store/!q;p'"'"' | sed '"'"'s/\/nix\/store\/[a-z0-9]*-//g'"'"' | sed '"'"'s/-.*//g'"'"' | uniq | tr '"'"'\n'"'"' '"'"' '"'"')';
    PS1='\n\[\e[33m\]''${PS1_CMD1}''${PS1_CMD1:+"\n"}\[\e[32;1m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\e[0m\] '
  '';
}
