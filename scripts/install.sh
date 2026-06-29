#!/usr/bin/env bash
# Install nvimGT — safe to pipe: curl -fsSL …/install.sh | bash
#
# Installs to ~/.config/nvimgt (NVIM_APPNAME=nvimgt) without touching ~/.config/nvim.
# Override: NVIMGT_REPO, NVIMGT_BRANCH, NVIMGT_DEST, NVIMGT_SKIP_PLUGINS=1

set -euo pipefail

REPO="${NVIMGT_REPO:-https://github.com/yonasuriv/nvimGT.git}"
BRANCH="${NVIMGT_BRANCH:-main}"
DEST="${NVIMGT_DEST:-$HOME/.config/nvimgt}"
ALIAS_LINE="alias nvimgt='NVIM_APPNAME=nvimgt nvim'"

brand() {
  printf "\033[1;37mnvim\033[0m \033[1;31mGT\033[0m"
}

die() {
  printf >&2 "\n"
  brand >&2
  printf >&2 " install error: %s\n" "$*"
  exit 1
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "'$1' is required but not installed."
}

printf "\n"
brand
printf " is being installed...\n\n"

need_cmd git
need_cmd nvim

if [[ -d "$DEST/.git" ]]; then
  printf "Updating existing install at %s\n" "$DEST"
  git -C "$DEST" fetch --depth 1 origin "$BRANCH"
  git -C "$DEST" checkout "$BRANCH"
  git -C "$DEST" reset --hard "origin/$BRANCH"
elif [[ -e "$DEST" ]]; then
  die "$DEST already exists and is not a git repository. Remove it or set NVIMGT_DEST."
else
  mkdir -p "$(dirname "$DEST")"
  printf "Cloning %s → %s\n" "$REPO" "$DEST"
  git clone --depth 1 --branch "$BRANCH" "$REPO" "$DEST"
fi

add_alias() {
  local rc="$1"
  [[ -f "$rc" ]] || return 0
  if grep -qF "NVIM_APPNAME=nvimgt nvim" "$rc" 2>/dev/null; then
    return 0
  fi
  {
    printf "\n# nvimGT\n"
    printf "%s\n" "$ALIAS_LINE"
  } >>"$rc"
  printf "Added nvimgt alias to %s\n" "$rc"
}

add_alias "$HOME/.bashrc"
add_alias "$HOME/.zshrc"

if [[ "${NVIMGT_SKIP_PLUGINS:-0}" != "1" ]]; then
  printf "\nBootstrapping plugins (lazy.nvim)...\n"
  NVIM_APPNAME=nvimgt nvim --headless "+Lazy! sync" +qa || die "Plugin sync failed. Re-run: NVIM_APPNAME=nvimgt nvim"
fi

printf "\n"
brand
printf " installed.\n\n"
printf "  Launch:  nvimgt\n"
printf "           (or: NVIM_APPNAME=nvimgt nvim)\n"
printf "  Config:  %s\n" "$DEST"
printf "  Reload shell if 'nvimgt' is not found yet.\n\n"
