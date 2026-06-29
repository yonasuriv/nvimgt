# ROADMAP

## Completed (2026-06-29)

- [x] Full repo audit in `docs/audit/`
- [x] Folder-structure audit for every `lua/` file
- [x] Move vendored LazyVim trees to `reference/lazyvim/`
- [x] Salvage NvChad keymaps → `config/keymaps.lua`
- [x] Salvage gitsigns/mason/treesitter opts → `plugins/*.lua`
- [x] Delete orphan NvChad `config/` fragments
- [x] NvChad/ui statusline + tabufline (`nvchad-ui.lua`, `chadrc.lua`, base46)
- [x] Fix `nvimgt.utils.commands` module path
- [x] AstroDark base46 theme (`lua/themes/astrodark.lua`) + dashboard palette
- [x] `:cheatsheet` / `:theme` commands + dashboard keys; catppuccin excluded from picker

## Next — lazyload + nvimGT migration

- [ ] Replace user-visible "LazyVim" strings in remaining runtime paths
- [ ] Introduce `nvimgt.lazyload` helper namespace (wrap `LazyVim.on_load` / deferred patterns)
- [ ] Evaluate dropping `LazyVim/LazyVim` import once LSP + extras have nvimGT equivalents
- [ ] Add `lua/plugins/extras/` only for **custom** extras (not upstream copies)

## Next — documentation & assets

- [ ] Add `.github/assets/` images or simplify README header
- [x] Ship `config.json` (via `vim.g.lazyvim_json`) instead of gitignored `lazyvim.json`
- [x] Dotfiles audit — removed unused `.vim.yml`
- [ ] Create `CHANGELOG.md` on first release tag

## Observations

- Catppuccin optional integrations existed only in reference extras; active theme is base46 (`chadrc.lua`, default `onedark`).
- `:LazyExtras` + upstream LazyVim is the correct extras workflow — no local `extras/` copy needed.
