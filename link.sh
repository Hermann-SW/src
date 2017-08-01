#!/usr/bin/env zsh

# Create symlines in ~ for files in curtis.

set -o errexit -o nounset -o pipefail

error() {
  echo "$1"
  exit 1
}

link() {
  local source_path="$PWD/curtis/$1"
  local dest_path="$HOME/$1"

  [ -h "$dest_path" ] && return
  [ -e "$dest_path" ] && error "$dest_path exists"

  mkdir -p "$(dirname "$dest_path")"
  ln -s "$source_path" "$dest_path"
  echo "$1"
}

link '.bin/bri.c'
link '.bin/dtch.c'
link '.bin/hnel.c'
link '.bin/jrp.c'
link '.bin/pbd.c'
link '.bin/sup'
link '.bin/tup'
link '.bin/up'
link '.bin/xx.c'
link '.config/git/config'
link '.config/git/ignore'
link '.config/htop/htoprc'
link '.config/nvim/colors/trivial.vim'
link '.config/nvim/init.vim'
link '.config/nvim/syntax/nasm.vim'
link '.config/nvim/syntax/scala.vim'
link '.gdbinit'
link '.gnupg/gpg-agent.conf'
link '.hushlogin'
link '.inputrc'
link '.nethackrc'
link '.psqlrc'
link '.ssh/config'
link '.zshrc'
