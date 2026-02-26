-- Key mappings
vim.g.mapleader = " " -- Set leader key to space
vim.g.maplocalleader = " " -- Set local leader key (NEW)

vim.keymap.set({ "n" }, "<leader>r", ":source ~/.config/nvim/init.lua<CR>", { desc = "Reload Neovim configuration" })
vim.keymap.set({ "n" }, "<Esc>", ":nohlsearch<CR>", { desc = "Hide the search pattern highlights" })
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y<CR>', { desc = "Yank into clipboard register" })
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d<CR>', { desc = "Cut into clipboard register" })

-- Better split navigation -- movements don't work for some reason!
vim.keymap.set({ "n" }, "<leader>s", ":split<CR>", { desc = "Split horizontally" })
vim.keymap.set({ "n" }, "<leader>v", ":vsplit<CR>", { desc = "Split vertically" })

-- vim.keymap.set("n", "<C-h>", "<C-w>h")
-- vim.keymap.set("n", "<C-j>", "<C-w>j")
-- vim.keymap.set("n", "<C-k>", "<C-w>k")
-- vim.keymap.set("n", "<C-l>", "<C-w>l")
--
-- Easier buffer navigation
vim.keymap.set({ "n" }, "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set({ "n" }, "<S-Tab>", ":bprev<CR>", { desc = "Previous buffer" })
