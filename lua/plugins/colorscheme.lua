-- XLVIM colorscheme: AstroNvim AstroDark
return {
  -- Load astrotheme early so astrodark is available during startup
  {
    "AstroNvim/astrotheme",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- Tell LazyVim to use astrodark as the active colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "astrodark",
    },
  },
}
