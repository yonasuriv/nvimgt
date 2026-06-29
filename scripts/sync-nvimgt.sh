#!/usr/bin/env bash
# Sync nvimGT dev config to the deployed location for live testing.
# Usage:
#   ./sync-nvimgt.sh            # one-time copy
#   ./sync-nvimgt.sh --watch    # copy now, then watch for changes and re-copy

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/../"
DST="$HOME/.config/nvimgt"

do_sync() {
  rsync -a --delete \
    --exclude '.git/' \
    --exclude '*.swp' \
    --exclude '*~' \
    "$SRC/" "$DST/"
  echo "[nvimgt] synced at $(date '+%H:%M:%S')"
}

case "${1:-}" in
  --watch)
    do_sync
    echo "[nvimgt] watching $SRC for changes (Ctrl-C to stop)..."
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
