-- nvimGT gitsigns: gutter icon overrides (salvaged from NvChad base46 git theme)
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        delete = { text = "󰍵" },
        changedelete = { text = "󱕖" },
      },
    },
  },
}
