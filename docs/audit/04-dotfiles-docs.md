# Audit: Dotfiles & Documentation

## Dotfiles

| File | Purpose | Verdict |
|------|---------|---------|
| `.editorconfig` | UTF-8, 2-space indent | **KEEP** |
| `.markdownlint.yaml` | MD lint relaxations | **KEEP** (optional) |
| `.neoconf.json` | neoconf / lua_ls workspace | **KEEP** |
| `.selene.toml` | Selene Lua linter | **KEEP** if used |
| `.stylua.toml` | StyLua formatter | **KEEP** — docs wrongly say `stylua.toml` |
| `.vim.yml` | Selene globals | **KEEP** or delete if unused |
| `.gitignore` | Ignores `lazy-lock.json`, `lazyvim.json`, `plugins.json` | **UPDATE** policy vs docs |

## Missing / broken

| Item | Issue |
|------|-------|
| `plugins.json` | Documented but missing + gitignored |
| `.github/assets/nvimgt-*.png` | README references missing images |
| Kickstart URL in README | `nvim-lua/nvimgt/kickstart.nvim` → wrong |
| `scripts/sync-nvimgt-config.sh` | Actual script: `scripts/sync-nvimgt.sh` |
| `CHANGELOG.md`, `TODO.md`, `ROADMAP.md` | Referenced by AGENTS.md, missing |

## Documentation drift

| Doc | Stale content |
|-----|---------------|
| `README.md` | Old file layout; LazyVim extras wording; typo "tp"; Neovim ≥0.10 vs 0.11.2 gate in review/init |
| `docs/configuration.md` | `lua/config/`, `lua/plugins/`, `{ import = "plugins" }` |
| `docs/development.md` | Same path drift; wrong script name |
| `docs/superpowers/` | Pre-`nvimgt/` namespace plan — archive |
| `CONTRIBUTING.md` | `lua/plugins/` paths |

## Orphan config (cross-ref)

Nine files in `lua/nvimgt/config/` not loaded — see [05-folder-structure.md](./05-folder-structure.md).

## Recommended new docs

- `docs/architecture.md` — load chain, what nvimGT owns vs LazyVim
- `docs/extras.md` — `:LazyExtras`, `lazyvim.json`, user extras path
