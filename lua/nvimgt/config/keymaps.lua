-- nvimGT keymaps
-- Personal bindings. LazyVim defaults load first; maps here extend or override them.
-- Salvaged from NvChad starter patterns — adapted for Snacks picker, conform, and heirline.

local map = vim.keymap.set

-- Insert mode: Emacs-style cursor movement within the line
map("i", "<C-b>", "<ESC>^i", { desc = "Move to beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move to end of line" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- Normal mode: jump between windows with Ctrl+hjkl
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })

-- Smart Escape: close help/floats, close file (confirm), or clear search
map("n", "<Esc>", function()
  require("nvimgt.utils.escape").normal()
end, { desc = "Close window/buffer or clear search" })

-- Quick save and copy entire buffer
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file" })

-- Toggle absolute and relative line numbers
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle line numbers" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle relative line numbers" })

-- Format buffer with conform (falls back to LSP when no formatter matches)
map({ "n", "x" }, "<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "Format file" })

-- Send buffer diagnostics to the location list
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- Toggle line comment (delegates to mini.comment via gcc/gc remap)
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Picker shortcuts (Snacks via LazyVim.pick — NvChad telescope equivalents)
map("n", "<leader>ff", function()
  LazyVim.pick()()
end, { desc = "Find files" })
map("n", "<leader>fw", function()
  LazyVim.pick("live_grep")()
end, { desc = "Live grep" })
map("n", "<leader>fb", function()
  LazyVim.pick("buffers")()
end, { desc = "Find buffers" })
map("n", "<leader>fh", function()
  LazyVim.pick("help")()
end, { desc = "Help tags" })
map("n", "<leader>fo", function()
  LazyVim.pick("oldfiles")()
end, { desc = "Recent files" })
map("n", "<leader>fz", function()
  LazyVim.pick("grep_buffer")()
end, { desc = "Search in current buffer" })
map("n", "<leader>fa", function()
  LazyVim.pick("files", { hidden = true, no_ignore = true })()
end, { desc = "Find all files" })

-- File explorer (Snacks explorer instead of NvChad nvim-tree)
map("n", "<C-n>", function()
  require("nvimgt.utils.commands").explorer()
end, { desc = "Open explorer" })
map("n", "<leader>e", function()
  require("nvimgt.utils.commands").explorer()
end, { desc = "Open explorer" })
map("n", "<leader>fe", function()
  require("nvimgt.utils.commands").explorer()
end, { desc = "Open explorer (root dir)" })

-- nvimGT shortcuts (dashboard keys h/t/l match actions shown on startup screen)
map("n", "t", function()
  require("nvimgt.utils.commands").theme()
end, { desc = "Theme picker" })

-- Terminal: leave terminal mode with Ctrl+x
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Exit terminal mode" })

-- Floating terminal via Snacks (NvChad term.toggle equivalent)
map({ "n", "t" }, "<A-i>", function()
  Snacks.terminal.toggle({ win = { position = "float" } })
end, { desc = "Toggle floating terminal" })

map({ "n", "t" }, "<A-h>", function()
  Snacks.terminal.toggle({ win = { position = "bottom" } })
end, { desc = "Toggle horizontal terminal" })

map({ "n", "t" }, "<A-v>", function()
  Snacks.terminal.toggle({ win = { position = "right" } })
end, { desc = "Toggle vertical terminal" })
