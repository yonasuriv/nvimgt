# nvimGT Repository Audit — Executive Summary

**Date:** 2026-06-29  
**Scope:** Full repo — active config, vendored plugins, dotfiles, docs, and **folder placement** for every `lua/` file.

## Quick verdict

| Area | Status |
|------|--------|
| Active UI layer (5 plugin specs) | Works; minor comment/branding fixes needed |
| `config/` folder | 4 correct files + 9 misplaced NvChad legacy files |
| `plugins/review/` + `plugins/lsp/` | 2 files **loaded** as duplicates; 9 siblings dead but confusing |
| `plugins/extras/` | 115 files — **never loaded**, identical to LazyVim upstream |
| Documentation | Stale paths (`lua/config/`, `lua/plugins/`), broken README assets/URLs |
| Folder hygiene | **11 / 146** Lua files in the correct place ([details](./05-folder-structure.md)) |

---

## Audit documents

| # | Document | Contents |
|---|----------|----------|
| 01 | [active-plugins.md](./01-active-plugins.md) | Runtime-loaded files, branding, comments, conflicts |
| 02 | [review-lsp.md](./02-review-lsp.md) | Vendored LazyVim core/LSP copies |
| 03 | [extras.md](./03-extras.md) | 115 extra specs, picker/dashboard/completion conflicts |
| 04 | [dotfiles-docs.md](./04-dotfiles-docs.md) | Root dotfiles, README, docs drift |
| 05 | [folder-structure.md](./05-folder-structure.md) | **Every `lua/` file — type vs location** |
| 07 | [dotfiles.md](./07-dotfiles.md) | Root dotfiles necessity and stale reference cleanup |

---

## Decisions needed (pros & cons)

Answer these to drive the cleanup. Each option assumes credits to LazyVim/AstroNvim/plugin authors stay in README.

### Q1 — LazyVim as distribution layer

nvimGT currently boots `{ "LazyVim/LazyVim", import = "lazyvim.plugins" }` plus local overrides.

| Option | Pros | Cons |
|--------|------|------|
| **A. Keep LazyVim import** (recommended short-term) | Full extras/LSP/format stack; `:LazyExtras` works; minimal maintenance | User-facing "LazyVim" leakage; large transitive dependency |
| **B. Fork gradually** | Full nvimGT branding; smaller rtp over time | Months of work; must reimplement `LazyVim.*` helpers or replace |
| **C. Drop LazyVim, keep lazy.nvim only** | Clean ownership | Lose extras, LSP defaults, keymaps — rebuild from scratch |

**Current recommendation:** **A** — keep LazyVim, delete local duplicates, fix branding in nvimGT-owned files only.

---

### Q2 — `plugins/review/` + `plugins/lsp/` (11 files)

| Option | Pros | Cons |
|--------|------|------|
| **A. Delete from `plugins/`** | Stops duplicate lazy specs + double `lazyvim.config.init()` | Lose offline diff copies |
| **B. Move to `reference/lazyvim/`** | Keep snapshots for comparison; zero rtp impact | Extra folder to maintain |
| **C. Keep as-is** | No work | Redundant merge noise; `review/init.lua` loaded today |

**Current recommendation:** **B** — move entire `review/` and `lsp/` to `reference/lazyvim/plugins/`.

---

### Q3 — `plugins/extras/` (115 files)

| Option | Pros | Cons |
|--------|------|------|
| **A. Delete entirely** | −115 files; use `:LazyExtras` + upstream LazyVim | Cannot fork extras in-repo without re-copying |
| **B. Move to `reference/lazyvim/plugins/extras/`** | Snapshot for diffs | Still in repo, larger clone |
| **C. Migrate to `lua/plugins/extras/`** | LazyVim "User extras" discovery works | Only worth it for **customized** extras; identical copies pointless |
| **D. Wire `nvimgt.plugins.extras` in lazy.lua** | Centralized extras path | Must rename module + update LazyExtras sources; duplicates upstream |

**Current recommendation:** **A** or **B** — no file is customized vs upstream.

---

### Q4 — Orphan `config/` files (9 NvChad-era files)

Files: `cmp`, `lspconfig`, `mason`, `telescope`, `tree`, `treesitter`, `gitsigns`, `luasnip`, `mappings`.

| Option | Pros | Cons |
|--------|------|------|
| **A. Delete all 9** | Clean `config/`; no NvChad breakage risk | Lose `mappings.lua` keymaps (some are useful) |
| **B. Salvage maps → `keymaps.lua`, delete rest** | Keeps generic maps (save, format, LSP) without NvChad | Must rewrite NvChad-specific bindings (`NvCheatsheet`, telescope) |
| **C. Convert plugin tables → `plugins/*.lua` specs** | Revives telescope/tree config | Conflicts with LazyVim/Snacks defaults |

**Current recommendation:** **B** — merge non-NvChad maps into `keymaps.lua`, delete the rest.

---

### Q5 — Branding: LazyVim → nvimGT in the app

| Surface | Current | Target |
|---------|---------|--------|
| `:checkhealth nvimgt` | "LazyVim" section titles | "nvimGT" |
| Dashboard / statusline / tabline | Mostly nvimGT already | Keep |
| `:LazyExtras` command name | LazyVim upstream | Keep (upstream feature); document as "nvimGT Extras" in docs? |
| Code comments | Mix of LazyVim + nvimGT | nvimGT header + credit line for upstream patterns |
| `LazyVim.*` API in lua | Used in `statusline.lua` | Keep while Q1=A |

**Terminology:** Use **lazy.nvim** for the plugin manager (folke), **lazyload** in docs when describing deferred plugin loading (`lazy = true`), **LazyVim** only in Credits/inspiration.

---

### Q6 — Colorscheme: Catppuccin references

Only in unloaded `extras/coding/blink.lua` and `extras/editor/overseer.lua` (optional integrations). Active theme is **AstroDark** via `colorscheme.lua`.

| Option | Pros | Cons |
|--------|------|------|
| **A. Ignore** (extras deleted/moved) | No action | — |
| **B. Strip catppuccin blocks when keeping extras** | Aligns with AstroDark-only policy | Edits in reference copies only |

**Current recommendation:** **A** if Q3 deletes/moves extras.

---

### Q7 — Documentation & tracking files

| Item | Issue | Recommendation |
|------|-------|----------------|
| `plugins.json` in README | File missing; gitignored | Document `lazyvim.json` instead |
| `lazyvim.json` gitignored | Extras state not versioned | Track in repo OR document as local-only |
| `docs/superpowers/` | Stale xlvim plan | Archive or delete |
| README images | `.github/assets/` missing | Add assets or remove `<picture>` block |
| Kickstart URL | Broken path | Fix to `github.com/nvim-lua/kickstart.nvim` |
| `CHANGELOG.md`, `TODO.md`, `ROADMAP.md` | Missing per AGENTS.md | Create minimal stubs |

---

## Suggested execution order

1. **Your answers** to Q1–Q7 (can be partial).
2. **P0 folder fixes** — remove/move `review/init.lua`, `lsp/init.lua`; delete orphan `config/` (per Q4).
3. **Branding** — `health.lua`, comments on active plugin specs.
4. **Extras tree** — per Q3.
5. **Docs** — README, configuration.md, development.md, new `docs/architecture.md`.
6. **Final comparison doc** — `docs/audit/06-decisions-applied.md` after implementation.

---

## What is already correct

These files are in the right place and actively loaded:

- `init.lua`
- `lua/nvimgt/config/{lazy,options,keymaps,autocmds}.lua`
- `lua/nvimgt/plugins/{colorscheme,completion,dashboard,statusline,tabline}.lua`
- `lua/nvimgt/health.lua`, `lua/nvimgt/types.lua`

See [05-folder-structure.md](./05-folder-structure.md) for the full per-file matrix.
