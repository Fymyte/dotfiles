#! /usr/bin/env sh

CLONED_DIR="$HOME/.cache/chezmoi/Colloid-theme/"
DEST_DIR="$HOME/.icons"

install() {
  if [ -d "$1" ]; then
    (
      cd "$1" || return
      ./install.sh --dest "$DEST_DIR"
    )
  fi
}

install "$CLONED_DIR"
