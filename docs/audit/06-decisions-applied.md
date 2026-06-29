# Decisions Applied (2026-06-29)

User choices from the audit questionnaire and what was done.

| Question | Decision | Applied |
|----------|----------|---------|
| Q1 Base layer | **lazyload + nvimGT** (migrate off LazyVim branding; keep import short-term) | Docs use "lazyload"; `lazy.lua` comment updated; `docs/architecture.md` + `ROADMAP.md` migration plan |
| Q2 review/lsp | **Move to `reference/lazyvim/`** | `review/`, `lsp/`, `extras/` moved — 126 files off rtp |
| Q3 extras | **`:LazyExtras` + upstream** (not local copy) | Deleted from `lua/`; `reference/lazyvim/README.md` explains workflow |
| Q4 orphan config | **Salvage keymaps + valid opts, delete rest** | `keymaps.lua` expanded; `gitsigns.lua`, `mason.lua`, `treesitter.lua` added; 9 NvChad `config/` files removed |

## Extras clarification

| Command | What it does |
|---------|----------------|
| `:Lazy` | lazy.nvim plugin manager UI |
| `:LazyExtras` | Browse/toggle **upstream** LazyVim optional packs |
| `:Lazy load <name>` | Load one deferred plugin on demand |

You do **not** need a local `lua/nvimgt/plugins/extras/` tree. Custom packs you write go in `lua/plugins/extras/`.

## Folder structure after cleanup

```
lua/nvimgt/
├── config/          # 4 files only (lazy, options, keymaps, autocmds)
├── plugins/         # 8 active specs
├── health.lua
└── types.lua

reference/lazyvim/plugins/
├── review/          # 9 files
├── lsp/             # 2 files
└── extras/          # 115 files
```

See [05-folder-structure.md](./05-folder-structure.md) for the per-file type matrix.

## Still open

- Full LazyVim import removal (ROADMAP)
- `nvimgt.lazyload` utility module
- README header images (`.github/assets/`)
- `lazyvim.json` track vs gitignore policy
