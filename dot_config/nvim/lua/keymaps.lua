-- Key mappings
vim.g.mapleader = " " -- Set leader key to space
vim.g.maplocalleader = " " -- Set local leader key (NEW)

vim.keymap.set({ "n" }, "<leader>o", ":update<CR>:source<CR>", { desc = "Write and reload the Neovim configuration" })
vim.keymap.set({ "n" }, "<Esc>", ":nohlsearch<CR>", { desc = "Hide the search pattern highlights" })
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y<CR>', { desc = "Yank into clipboard register" })
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d<CR>', { desc = "Cut into clipboard register" })

