-- nvimGT colorscheme: AstroNvim AstroDark + dashboard highlight overrides
return {
  {
    "AstroNvim/astrotheme",
    lazy = false,
    priority = 1000,
    opts = {
      highlights = {
        global = {
          -- Dashboard: white header, red icons/keys, grey descriptions, dimmed footer
          SnacksDashboardHeader  = { fg = "#E0E0EE", bold = true },
          SnacksDashboardIcon    = { fg = "#FF838B" },
          SnacksDashboardDesc    = { fg = "#9B9FA9" },
          SnacksDashboardKey     = { fg = "#FF838B" },
          SnacksDashboardFooter  = { fg = "#595C66" },
          SnacksDashboardSpecial = { fg = "#595C66" },
        },
      },
    },
  },

  -- Tell LazyVim to use astrodark as the active colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "astrodark",
    },
  },
}
