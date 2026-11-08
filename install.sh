#!/usr/bin/env bash
#
# install.sh - symlink dotfiles from home/ into $HOME.
#
# Usage:
#   ./install.sh            create symlinks, backing up anything they replace
#   ./install.sh --dry      show what would happen, change nothing
#
# Existing files are moved to ~/.dotfiles-backup/<timestamp>/ before linking,
# so nothing is lost. Running it again is safe: correct links are left alone.
#
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_SRC="$DOTFILES_DIR/home"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

DRY=false
BACKED_UP=false
case "${1:-}" in
  --dry) DRY=true ;;
  "") ;;
  *) echo "usage: $0 [--dry]" >&2; exit 2 ;;
esac

# Files in home/ that are templates or docs, not meant to be linked into ~.
SKIP=(".zshrc.local.example")

is_skipped() {
  local name="$1" s
  for s in "${SKIP[@]}"; do [[ "$name" == "$s" ]] && return 0; done
  return 1
}

run() {
  if $DRY; then echo "      (dry) $*"; else "$@"; fi
}

link() {
  local src="$1" dest="$2"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "ok     $dest"
    return
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    local rel="${dest#"$HOME"/}"
    echo "backup $dest -> $BACKUP_DIR/$rel"
    run mkdir -p "$(dirname "$BACKUP_DIR/$rel")"
    run mv "$dest" "$BACKUP_DIR/$rel"
    BACKED_UP=true
  fi

  echo "link   $dest -> $src"
  run mkdir -p "$(dirname "$dest")"
  run ln -s "$src" "$dest"
}

# The tracked .zshrc keeps secrets in ~/.zshrc.local. Linking it without that
# file would silently drop those variables from your shell, so stop first.
if [[ -f "$HOME_SRC/.zshrc" && ! -f "$HOME/.zshrc.local" ]]; then
  echo "error: ~/.zshrc.local does not exist." >&2
  echo "       Copy $HOME_SRC/.zshrc.local.example to ~/.zshrc.local," >&2
  echo "       fill in your real values, then run this again." >&2
  $DRY || exit 1
  echo "       (continuing because this is a dry run)" >&2
  echo
fi

shopt -s dotglob nullglob
for f in "$HOME_SRC"/*; do
  name="$(basename "$f")"
  is_skipped "$name" && continue
  link "$f" "$HOME/$name"
done
shopt -u dotglob nullglob

echo
if $DRY; then
  echo "Dry run only. Nothing was changed."
elif $BACKED_UP; then
  echo "Done. Replaced files were backed up to: $BACKUP_DIR"
else
  echo "Done. Nothing needed backing up."
fi
