-- nvimGT LazyVim overrides (distribution layer stays imported; silence upstream onboarding)
return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- Welcome toast + NEWS.md popup: lua/lazyvim/util/news.lua (LazyVim.config.init)
      news = {
        lazyvim = false,
        neovim = false,
      },
    },
  },
}
