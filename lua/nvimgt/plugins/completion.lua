-- nvimGT completion: show documentation window automatically
return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      local prev = opts.enabled
      opts.enabled = function()
        if vim.bo.buftype == "prompt" or vim.bo.filetype == "VoltWindow" then
          return false
        end
        if type(prev) == "function" then
          return prev()
        end
        return prev ~= false
      end
      opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      })
      return opts
    end,
  },
}
