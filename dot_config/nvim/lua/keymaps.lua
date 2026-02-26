-- Key mappings
vim.g.mapleader = " " -- Set leader key to space
vim.g.maplocalleader = " " -- Set local leader key (NEW)

vim.keymap.set({ "n" }, "<leader>r", ":source ~/.config/nvim/init.lua<CR>", { desc = "Reload Neovim configuration" })
vim.keymap.set({ "n" }, "<Esc>", ":nohlsearch<CR>", { desc = "Hide the search pattern highlights" })
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y<CR>', { desc = "Yank into clipboard register" })
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d<CR>', { desc = "Cut into clipboard register" })

-- Better split navigation -- movements don't work for some reason!
vim.keymap.set({ "n" }, "<leader>h", ":split<CR>", { desc = "Split horizontally" })
vim.keymap.set({ "n" }, "<leader>v", ":vsplit<CR>", { desc = "Split vertically" })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Easier buffer navigation
vim.keymap.set({ "n" }, "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set({ "n" }, "<S-Tab>", ":bprev<CR>", { desc = "Previous buffer" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "Y", "yy")

-- autocomplete in normal text
vim.keymap.set("i", "<C-f>", "<C-x><C-f>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-n>", "<C-x><C-n>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-l>", "<C-x><C-l>", { noremap = true, silent = true })

-- make Enter choose the selected completion text
vim.cmd(":inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'")
