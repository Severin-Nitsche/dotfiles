#! /usr/bin/env bash

declare -A linked
for i in ~/Applications/Home\ Manager\ Apps/*; do
  dest="$(readlink "$i")"
  linked["$dest"]="1"
done

existingPaths="$(/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -dump | grep -e "path: */nix/" | sed -E 's/.*(\/nix\/.*) \(0x[0-9a-f]+\)/\1/')"

set +o nounset
unregistered="0"
IFS=$'\n'; for i in $existingPaths; do
  if [ "${linked["$i"]}" != "1" ]; then
    echo "Unregistering $i"
    "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister" -u "$i"
    unregistered="1"
  fi
done
set -o nounset

if [ "$unregistered" == "1" ]; then
  find /private/var/folders/ -type d -name com.apple.dock.launchpad -exec rm -rf {} + 2>/dev/null; killall Dock
  # darwin-rebuild switch --flake .#sevs-kekbook-pro
fi
