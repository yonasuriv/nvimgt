-- nvimGT mason: installer UI tweaks (salvaged from NvChad mason config)
return {
  {
    "mason-org/mason.nvim",
    opts = {
      PATH = "skip",
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
      max_concurrent_installers = 10,
    },
  },
}
