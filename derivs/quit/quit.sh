if [[ -z ${1+x} || "$1" == "-h" || "$1" == "--help" || "$1" == "-help" ]]; then
cat <<EOF
Usage: $0 [fail|normal|all|force]

This program kills tmux for you.

fail      Print a funny message
normal    Kill current pane, window or session 
all       Err on multiple panes/windows otherwise kill the session
force     Kill the session
EOF
fi

if [[ "$1" == "fail" ]]; then
  declare -a msg
  msg[0]="Why would you want to QUIT vim?"
  msg[1]="If you leave, I WILL hurt myself!"
  msg[2]="bash: exit: Kommando nicht gefunden"
  msg[3]="Cannot exit while remote connection to nsa.gov is active"
  msg[4]="command exit: too little arguments (need at least 1)"
  msg[5]="exit DEINE MUDDA"
  msg[6]="Shutdown scheduled for $(date -d "+1 minute"), use 'shutdown +0' to cancel."
  msg[7]="Segmentation fault (core dumped)"
  msg[8]="Kernel Panic: Good Luck, Buddy"
  msg[9]=':(){ :|:& };:'
  msg[10]="Your PC ran into a problem and needs to restart. We're just collecting some error info, and then we'll restart for you."
  msg[11]="Out of memory: Kill process, or sacrifice child"
  msg[12]="Something happened"
  msg[13]="Task failed successfully"
  msg[14]="Nice try"
  msg[15]="Can't delete system32. Not a windows system"
  msg[16]="Trying to restart MS-DOS"
  msg[17]="You can fix me. Don't go."
  msg[18]="Aggressively we all defend the role we play"
  msg[19]="We hope you enjoyed your stay"

  echo "${msg[$RANDOM % ${#msg[@]}]}"
  exit 1
fi

windows=$(tmux list-windows | wc -l)
panes=$(tmux list-panes | wc -l)

if [[ "$1" == "normal" ]]; then
  if [[ $panes -gt 1 ]]; then
    tmux kill-pane
  elif [[ $windows -gt 1 ]]; then
    tmux kill-window
  else
    tmux kill-session
  fi
  exit 0
fi

if [[ "$1" == "all" ]]; then
  if [[ $windows -gt 1 || $panes -gt 1 ]]; then
    echo "There are still $windows open window(s)"
    echo "There are still $panes open pane(s)"
  else
    tmux kill-session
  fi
  exit 0
fi

if [[ "$1" == "force" ]]; then
  tmux kill-session
  exit 0
fi

echo "Unrecognized option $1"
exit 1
