#! /usr/bin/env bash

# VPN with rbw integration
#
# Usage: $0 <username> <secret_name> -- <openconnect args ...>
#
# Arguments:
#   username        this will be passed to `openconnect -u`
#   secret_name     this will extract your *password* and *totp* from bw and
#                   pipe them in this order to the stdin of `openconnect`
#   openvpn args    these will be passed through to `openconnect`
#   --help / -h     print this help message

if [[ "$1" == "--help" || "$1" == "-h" || "$1" == "" ]]; then
  sed '/^[^#[:space:]]/q' "$0" | grep '^#' | grep -v '^#!' | sed 's/^# \{0,1\}//' | sed "s|\\\$0|$0|"
  exit 0
fi

user_name=$1
secret_name=$2

# forward $@ to --
for i in "$@"; do
  shift
  if [[ "$i" == "--" ]]; then
    break
  fi
done

echo $@

# Get the secrets
password=$(rbw get $secret_name)
totp=$(rbw totp $secret_name)

# Call the openvpn
{ echo $password; echo $totp; } | sudo openconnect -u $user_name -p "$@"
