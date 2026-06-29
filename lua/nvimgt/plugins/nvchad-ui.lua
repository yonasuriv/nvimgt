-- nvimGT: NvChad UI — statusline (stl) + tabufline; replaces lualine/heirline
return {
  { "nvim-lualine/lualine.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "rebelot/heirline.nvim", enabled = false },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "NvChad/base46",
    lazy = false,
    priority = 1000,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "NvChad/ui",
    lazy = false,
    priority = 1000,
    dependencies = {
      "NvChad/base46",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvzone/volt",
    },
    config = function()
      require("nvchad")
      require("nvimgt.utils.tabufline").setup()
    end,
  },
}
