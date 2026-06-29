-- nvimGT colorscheme: base46 via chadrc.lua (NvChad/base46)
-- AstroDark removed — NvChad statusline/tabufline need base46 highlight cache.

return {
  { "AstroNvim/astrotheme", enabled = false },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local cache = vim.g.base46_cache
        if cache and vim.fn.filereadable(cache .. "defaults") == 1 then
          dofile(cache .. "defaults")
        end
      end,
    },
  },
}
