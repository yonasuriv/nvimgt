# Contributing to nvimGT

nvimGT is a personal Neovim configuration, but improvements, bug reports, and suggestions are welcome.

## Reporting Issues

Open an issue with:

- Your Neovim version (`nvim --version`)
- Your OS and terminal
- The full error message or a minimal reproduction case
- What you expected vs. what happened

## Submitting Changes

1. Fork the repo and create a branch from `main`.
2. Make your changes in `lua/nvimgt/plugins/` or `lua/nvimgt/config/`.
3. Test with `NVIM_APPNAME=nvimgt nvim --headless -c "qa" 2>&1` — no output means no startup errors.
4. Format Lua files with StyLua (`stylua lua/`).
5. Open a pull request with a clear description of what changed and why.

## Guidelines

**Keep it focused.** nvimGT is not a plugin distribution — it is a curated personal config. Plugins should have a clear, concrete benefit and not duplicate existing functionality. Prefer configuring what is already installed over adding new plugins.

**No breaking changes to the core design without discussion.** The nvimGT UI layer (base46 + NvChad/ui tabufline/statusline + Snacks dashboard) is intentional.

**Respect the plugin loading model.** Use lazy.nvim's spec merge system (opts, keys, dependencies) rather than adding init scripts or patching third-party plugin files. See [docs/configuration.md](docs/configuration.md) for how the merge model works.

**Lua style.** Follow the conventions in the existing files: no trailing comments describing what the code does (let the code speak), and no large comment blocks. Format with StyLua.

## Development Workflow

See [docs/development.md](docs/development.md) for the full dev setup, sync script usage, and debugging tips.
