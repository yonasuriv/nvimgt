-- nvimGT UI — statusline (stl) + tabufline; replaces lualine/heirline
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
      -- NvChad persists theme/transparency edits via replace_word (default: chadrc.lua)
      local nvutils = require("nvchad.utils")
      local theme_path = vim.fn.stdpath("config") .. "/lua/nvimgt/config/theme.lua"
      local replace_word = nvutils.replace_word
      nvutils.replace_word = function(old, new, filepath)
        return replace_word(old, new, filepath or theme_path)
      end

      require("nvchad")
      require("nvimgt.utils.tabufline").setup()

      vim.api.nvim_create_user_command("NvCheatsheet", function()
        require("nvimgt.utils.cheatsheet").toggle()
      end, { force = true, desc = "nvimGT keymap cheatsheet" })
    end,
  },
}
