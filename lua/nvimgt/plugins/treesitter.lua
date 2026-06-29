-- nvimGT treesitter: ensure core grammars are installed on setup
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc" },
    },
  },
}
