# XLVIM

```text
          d8b            d8,
          88P           `8P
         d88
?88,  88P888  ?88   d8P  88b  88bd8b,d88b
 `?8bd8P'?88  d88  d8P'  88P  88P'`?8P'?8b
 d8P?8b,  88b ?8b ,88'  d88  d88  d88  88P
d8P' `?8b  88b`?888P'  d88' d88' d88'  88b
```

**XLVIM** — *eXtended Line-editor Visual Improved Mode* — is a personal Neovim configuration that merges the best parts of three popular distros:

- **[LazyVim](https://github.com/LazyVim/LazyVim)** as the solid plugin foundation
- **[AstroNvim](https://github.com/AstroNvim/AstroNvim)**'s gorgeous **AstroDark** colors and top buffer/tab bar
- **[NvChad](https://github.com/NvChad/NvChad)**'s clean, informative statusline

## Install

```bash
# Backup your existing Neovim config (optional)
mv ~/.config/nvim ~/.config/nvim.bak

# Clone XLVIM
git clone https://github.com/YOUR_USERNAME/xlvim ~/.config/nvim

# Start Neovim — lazy.nvim will bootstrap everything
nvim
```

## What's inside

| Feature | Implementation | Inspired by |
|---|---|---|
| Plugin manager | `lazy.nvim` + LazyVim distribution | LazyVim |
| Colorscheme | `AstroNvim/astrotheme` → `astrodark` | AstroNvim |
| Bottom statusline | `lualine.nvim` with NvChad-style sections | NvChad |
| Top buffer/tab bar | `heirline.nvim` custom tabline | AstroNvim |

## File layout

```text
lua/
├── config/
│   ├── lazy.lua      # lazy.nvim bootstrap + spec imports
│   ├── options.lua   # XLVIM options
│   ├── keymaps.lua   # your keymaps
│   └── autocmds.lua  # your autocommands
└── plugins/
    ├── colorscheme.lua  # AstroDark
    ├── statusline.lua   # NvChad-style lualine
    └── tabline.lua      # AstroNvim-style heirline tabline
```

## Customizing

Drop your own plugin specs in `lua/plugins/`. They will be picked up automatically by `lazy.nvim`. Override LazyVim defaults the same way — any spec for an existing plugin will be merged.

## License

MIT — see [LICENSE](./LICENSE).
