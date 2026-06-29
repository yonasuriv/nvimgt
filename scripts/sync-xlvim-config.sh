#!/usr/bin/env bash
# Sync XLVIM dev config to the deployed location for live testing.
# Usage:
#   ./sync-xlvim-config.sh            # one-time copy
#   ./sync-xlvim-config.sh --watch    # copy now, then watch for changes and re-copy

set -euo pipefail

SRC="../"
DST="$HOME/.config/xlvim"

do_sync() {
  rsync -a --delete \
    --exclude '.git/' \
    --exclude '*.swp' \
    --exclude '*~' \
    "$SRC/" "$DST/"
  echo "[xlvim] synced at $(date '+%H:%M:%S')"
}

case "${1:-}" in
  --watch)
    do_sync
    echo "[xlvim] watching $SRC for changes (Ctrl-C to stop)..."
    watchmedo shell-command \
      --patterns="*.lua;*.vim;*.toml;*.json;*.md" \
      --recursive \
      --wait \
      --command="\"$0\" --sync-once" \
      "$SRC"
    ;;
  --sync-once)
    do_sync
    ;;
  *)
    do_sync
    ;;
esac
