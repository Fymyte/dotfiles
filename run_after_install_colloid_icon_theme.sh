#! /usr/bin/env sh

CLONED_DIR="$HOME/.tmp/Colloid-theme/"

install() {
  if [ -d "$1" ]; then
    (
      cd "$1" || return
      ./install.sh
    )
    rm -rf "$1"
  fi
}

install "$CLONED_DIR"
