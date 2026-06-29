# Folder Structure Audit — `lua/`

Every file under `lua/` classified by **what it actually is** vs **where it lives today**, with a recommended target path.

## Target layout (recommended)

```
lua/
└── nvimgt/
    ├── health.lua              # :checkhealth nvimgt module
    ├── types.lua               # LuaLS @meta annotations (not runtime)
    ├── config/                 # Neovim user settings + lazy.nvim bootstrap ONLY
    │   ├── lazy.lua            # lazy.nvim setup + spec imports
    │   ├── options.lua         # vim.opt / vim.g user overrides
    │   ├── keymaps.lua         # vim.keymap.set personal bindings
    │   └── autocmds.lua        # vim.api.nvim_create_autocmd personal rules
    ├── plugins/                # lazy.nvim plugin specs (each file returns { ... })
    │   ├── colorscheme.lua
    │   ├── completion.lua
    │   ├── dashboard.lua
    │   ├── statusline.lua
    │   └── tabline.lua
    └── utils/                   # (future) nvimGT runtime helpers if LazyVim is dropped

lua/plugins/extras/             # (optional) LazyVim "User extras" — discovered by :LazyExtras
    └── <category>/<name>.lua   # NOT under nvimgt/plugins/extras/

reference/                      # (optional) vendored upstream snapshots — NOT on rtp
    └── lazyvim/
```

**Rules:**

| Folder | Accepts | Rejects |
|--------|---------|---------|
| `nvimgt/config/` | `vim.opt`, keymaps, autocmds, `lazy.setup` | Plugin `return { "author/plugin" }` specs, NvChad `dofile(base46_cache)`, utility modules |
| `nvimgt/plugins/` | Top-level lazy specs only (auto-imported one level deep) | Library modules (`keymaps.lua` with `M.get()`), vendored trees with `init.lua` duplicates |
| `nvimgt/utils/` | `require`-able helpers (`nvimgt.util.*`) | Plugin specs |
| `lua/plugins/extras/` | Optional extras toggled via `:LazyExtras` | Duplicates of LazyVim's built-in extras path |

---

## `lua/nvimgt/config/` — 13 files

| File | Actual type | Loaded? | Correct folder? | Recommended location | Action |
|------|-------------|---------|-------------------|----------------------|--------|
| `lazy.lua` | lazy.nvim bootstrap + spec imports | **Yes** | **Yes** | `config/lazy.lua` | **KEEP** |
| `options.lua` | `vim.opt` overrides | **Yes** | **Yes** | `config/options.lua` | **KEEP** |
| `keymaps.lua` | Personal keymaps (empty) | **Yes** | **Yes** | `config/keymaps.lua` | **KEEP** — migrate useful maps from `mappings.lua` |
| `autocmds.lua` | Personal autocommands (empty) | **Yes** | **Yes** | `config/autocmds.lua` | **KEEP** |
| `mappings.lua` | Keymap definitions (side-effect script) | **No** | **Wrong name** | `config/keymaps.lua` | **MERGE** salvageable maps into `keymaps.lua`, then **DELETE** |
| `cmp.lua` | nvim-cmp setup script (NvChad) | **No** | **Wrong folder** — plugin config | `plugins/cmp.lua` (lazy spec) or delete | **DELETE** — LazyVim uses blink.cmp |
| `lspconfig.lua` | LSP utility module (`M.on_attach`, capabilities) | **No** | **Wrong folder** — util, not config | `nvimgt/lsp/on_attach.lua` or `utils/lsp.lua` | **DELETE** — NvChad APIs; LazyVim owns LSP |
| `luasnip.lua` | Snippet loader side-effects | **No** | **Wrong folder** — plugin config | `plugins/luasnip.lua` or inside blink extra | **DELETE** — LazyVim handles luasnip |
| `gitsigns.lua` | Plugin opts table (no lazy wrapper) | **No** | **Wrong folder** — plugin spec body | `plugins/gitsigns.lua` | **DELETE** — NvChad base46; LazyVim configures gitsigns |
| `mason.lua` | Plugin opts table | **No** | **Wrong folder** | `plugins/mason.lua` | **DELETE** |
| `telescope.lua` | Plugin opts table | **No** | **Wrong folder** | `plugins/telescope.lua` | **DELETE** — nvimGT default picker is Snacks |
| `tree.lua` | nvim-tree opts table | **No** | **Wrong folder** | `plugins/tree.lua` | **DELETE** — explorer is Snacks/neo-tree via LazyVim |
| `treesitter.lua` | treesitter opts table | **No** | **Wrong folder** | `plugins/treesitter.lua` | **DELETE** |

**Summary:** 4 of 13 files belong in `config/`. One (`mappings.lua`) is the right *kind* of file but wrong *filename* and never loaded. Eight are misplaced NvChad-era plugin fragments.

---

## `lua/nvimgt/` root — 2 files

| File | Actual type | Correct folder? | Recommended location | Action |
|------|-------------|-----------------|----------------------|--------|
| `health.lua` | `:checkhealth` provider | **Yes** | `nvimgt/health.lua` | **KEEP** — rebrand user-visible "LazyVim" strings to "nvimGT" |
| `types.lua` | LuaLS `---@meta` stubs | **Yes** (or `types/init.lua`) | `nvimgt/types.lua` | **KEEP** — dev-only, not runtime |

---

## `lua/nvimgt/plugins/` top level — 5 active specs

| File | Actual type | Correct folder? | Action |
|------|-------------|-----------------|--------|
| `colorscheme.lua` | lazy.nvim plugin spec | **Yes** | **KEEP** |
| `completion.lua` | lazy.nvim plugin spec | **Yes** | **KEEP** |
| `dashboard.lua` | lazy.nvim plugin spec | **Yes** | **KEEP** |
| `statusline.lua` | lazy.nvim plugin spec | **Yes** | **KEEP** |
| `tabline.lua` | lazy.nvim plugin spec | **Yes** | **KEEP** |

These are the only plugin specs nvimGT intentionally owns today.

---

## `lua/nvimgt/plugins/review/` — 9 files

| File | Actual type | lazy.nvim discovers? | Correct folder? | Recommended location | Action |
|------|-------------|----------------------|-----------------|----------------------|--------|
| `init.lua` | lazy.nvim plugin spec (LazyVim core duplicate) | **Yes** (`nvimgt.plugins.review`) | **Wrong name & redundant** | Delete or `reference/lazyvim/plugins/init.lua` | **DELETE from plugins/** |
| `ui.lua` | lazy.nvim plugin spec | **No** (sibling of init.lua) | Misplaced vendored copy | `reference/lazyvim/plugins/ui.lua` | **RELOCATE** out of rtp |
| `coding.lua` | lazy.nvim plugin spec | **No** | Misplaced vendored copy | `reference/lazyvim/plugins/coding.lua` | **RELOCATE** |
| `editor.lua` | lazy.nvim plugin spec | **No** | Misplaced vendored copy | `reference/lazyvim/plugins/editor.lua` | **RELOCATE** |
| `formatting.lua` | lazy.nvim plugin spec | **No** | Misplaced vendored copy | `reference/lazyvim/plugins/formatting.lua` | **RELOCATE** |
| `linting.lua` | lazy.nvim plugin spec | **No** | Misplaced vendored copy | `reference/lazyvim/plugins/linting.lua` | **RELOCATE** |
| `treesitter.lua` | lazy.nvim plugin spec | **No** | Misplaced vendored copy | `reference/lazyvim/plugins/treesitter.lua` | **RELOCATE** |
| `util.lua` | lazy.nvim plugin spec | **No** | Misplaced vendored copy | `reference/lazyvim/plugins/util.lua` | **RELOCATE** |
| `xtras.lua` | lazy.nvim plugin spec (extras loader) | **No** | Misplaced vendored copy | `reference/lazyvim/plugins/xtras.lua` | **RELOCATE** |

**Why `review/` is wrong:** The name suggests "pending review" but `init.lua` is **loaded at runtime** and duplicates `lazyvim.plugins`. Siblings are dead code unless promoted to top-level `plugins/*.lua`, which would **conflict** with `statusline.lua`, `tabline.lua`, and `dashboard.lua`.

---

## `lua/nvimgt/plugins/lsp/` — 2 files

| File | Actual type | lazy.nvim discovers? | Correct folder? | Recommended location | Action |
|------|-------------|----------------------|-----------------|----------------------|--------|
| `init.lua` | lazy.nvim plugin spec (LSP stack duplicate) | **Yes** (`nvimgt.plugins.lsp`) | **Redundant with LazyVim** | Delete or `reference/lazyvim/plugins/lsp/init.lua` | **DELETE from plugins/** |
| `keymaps.lua` | Utility library (`M.get`, `M.set`) — **not** a plugin spec | **No** | **Wrong folder** — belongs in `utils/` | `nvimgt/lsp/keymaps.lua` or upstream only | **DELETE** — duplicate of `lazyvim.plugins.lsp.keymaps`; `lsp/init.lua` requires upstream path anyway |

**Anti-pattern:** Mixing a lazy spec (`init.lua`) with a library module (`keymaps.lua`) in the same folder implies both are plugin specs; only `init.lua` is imported.

---

## `lua/nvimgt/plugins/extras/` — 115 files

| Category | Count | Actual type | lazy.nvim discovers? | Correct folder? |
|----------|------:|-------------|----------------------|-----------------|
| `lang/` | 53 | lazy.nvim extra specs | **No** (no `extras/init.lua`, subdirs not scanned) | `lua/plugins/extras/lang/` for user extras **or** delete (use LazyVim upstream) |
| `editor/` | 18 | lazy.nvim extra specs | **No** | same |
| `utils/` | 9 | lazy.nvim extra specs | **No** | same |
| `ui/` | 9 | lazy.nvim extra specs | **No** | same |
| `ai/` | 9 | lazy.nvim extra specs | **No** | same |
| `coding/` | 8 | lazy.nvim extra specs | **No** | same |
| `lsp/` | 2 | lazy.nvim extra specs | **No** | same |
| `formatting/` | 2 | lazy.nvim extra specs | **No** | same |
| `dap/` | 2 | lazy.nvim extra specs | **No** | same |
| `linting/` | 1 | lazy.nvim extra specs | **No** | same |
| `test/` | 1 | lazy.nvim extra specs | **No** | same |
| root `vscode.lua` | 1 | lazy.nvim extra spec | **No** | same |

**Why current path is wrong:**

1. Lazy.nvim only imports **one level** under `nvimgt.plugins` — `extras/` is never walked.
2. LazyVim's `:LazyExtras` UI looks at `lazyvim.plugins.extras` (upstream) and `plugins.extras` (user), **not** `nvimgt.plugins.extras`.
3. All 115 files are byte-identical to LazyVim upstream — zero nvimGT customization.

**If you want local customized extras:** move edited files to `lua/plugins/extras/<category>/<name>.lua` and change imports to `nvimgt.plugins.extras` only after registering that module path in lazy setup.

---

## Cross-folder anti-patterns found

| Anti-pattern | Example | Problem |
|--------------|---------|---------|
| Plugin spec in `config/` | `config/telescope.lua` | `config/` is for user vim settings; breaks mental model and init.lua preload contract |
| Keymaps in wrong file | `config/mappings.lua` vs `config/keymaps.lua` | `init.lua` only preloads `keymaps` — maps in `mappings.lua` never run |
| Util module in `plugins/` | `plugins/lsp/keymaps.lua` | Not a `return { "plugin" }` spec; lazy won't load it as a plugin |
| Vendored upstream in `plugins/` | `review/`, `lsp/init.lua`, `extras/` | Pollutes rtp, causes duplicate spec merge, `review/init.lua` double-inits LazyVim |
| `init.lua` in plugin subfolder | `review/init.lua`, `lsp/init.lua`, `extras/lang/typescript/init.lua` | lazy.nvim auto-imports any `*/init.lua` under `nvimgt.plugins` — only `typescript/init.lua` among extras is at risk if `extras/` were ever promoted |
| NvChad `dofile(base46_cache)` | 7 config files | Requires NvChad runtime not present in nvimGT |

---

## File-type decision tree

```
Is it loaded by init.lua preload or lazy import?
├─ No  → candidate for DELETE or move to reference/
└─ Yes
   ├─ Sets vim.opt / keymaps / autocmds?
   │  └─ → nvimgt/config/{options,keymaps,autocmds}.lua
   ├─ Calls require("lazy").setup?
   │  └─ → nvimgt/config/lazy.lua
   ├─ Returns { "author/plugin.nvim", ... }?
   │  └─ → nvimgt/plugins/<name>.lua  (top level only)
   ├─ Returns { import = "..." } for extras?
   │  └─ → lua/plugins/extras/...  (LazyVim user extras convention)
   ├─ Exposes require("nvimgt.*") helpers?
   │  └─ → nvimgt/utils/...
   └─ :checkhealth or @meta only?
      └─ → nvimgt/health.lua or nvimgt/types.lua
```

---

## Priority moves (folder hygiene)

| Priority | Action | Files affected |
|----------|--------|----------------|
| **P0** | Remove loaded duplicates from `plugins/` | `review/init.lua`, `lsp/init.lua` |
| **P0** | Delete orphaned NvChad files from `config/` | 8 files (all except lazy/options/keymaps/autocmds/mappings) |
| **P1** | Relocate or delete `plugins/extras/` (115 files) | Entire tree → `reference/` or delete |
| **P1** | Relocate or delete `plugins/review/` siblings (8 files) | Non-init files |
| **P2** | Merge `mappings.lua` → `keymaps.lua` | 1 file |
| **P3** | Create `lua/plugins/extras/` only when adding **custom** extras | New files only |

---

## Counts (after 2026-06-29 cleanup)

| Location | Files | Correctly placed | Notes |
|----------|------:|-----------------:|-------|
| `nvimgt/config/` | 4 | 4 | Orphan NvChad files removed |
| `nvimgt/` root | 2 | 2 | health, types |
| `nvimgt/plugins/` (active) | 8 | 8 | +gitsigns, mason, treesitter salvaged |
| `reference/lazyvim/plugins/` | 126 | N/A | Off rtp — reference only |

**Before cleanup:** 11 / 146 runtime files correctly placed.  
**After cleanup:** all 14 files under `lua/nvimgt/` are correctly placed.

## Historical issues (resolved)

| Issue | Resolution |
|-------|------------|
| `plugins/review/init.lua` loaded as duplicate | Moved to `reference/lazyvim/` |
| `plugins/lsp/init.lua` loaded as duplicate | Moved to `reference/lazyvim/` |
| `plugins/extras/` 115 dead files | Moved to `reference/lazyvim/` |
| 9 NvChad files in `config/` | Deleted; salvaged into `keymaps.lua` + plugin specs |
| `mappings.lua` wrong filename | Merged into `keymaps.lua` |
