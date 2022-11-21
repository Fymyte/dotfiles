#! /usr/bin/env sh

CLONED_DIR="$HOME/.tmp/Colloid-theme/"

install() {
  if [ -d "$1" ]; then
    DIR=$(pwd)
    cd "$1"
    ./install.sh
    cd "$DIR"
    rm -rf "$1"
  fi
}

install "$CLONED_DIR"
