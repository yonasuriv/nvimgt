# TODO

## Observations

### LSP semantic tokens (from NvChad `lspconfig.lua` salvage)

The old NvChad `lspconfig.lua` disabled **LSP semantic tokens** (`textDocument/semanticTokens`) on attach. Some themes handle semantic highlighting poorly; disabling it keeps colors from Treesitter + AstroDark only.

**Status:** Not ported yet — LazyVim defaults may already handle this per server.

**Action when needed:** Add `lua/nvimgt/plugins/lsp-overrides.lua` with an `on_init` hook that clears `semanticTokensProvider` if colors look double-highlighted or clash with AstroDark.

**Decision:** Observe first; port only if a real visual issue appears.
