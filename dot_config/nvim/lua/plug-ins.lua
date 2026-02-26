-- Plugins
vim.pack.add({
	{ src = "https://github.com/mini-nvim/mini.nvim" }, -- Collection of several small plugins
	{ src = "https://github.com/stevearc/oil.nvim" }, -- File manager
	{ src = "https://github.com/folke/which-key.nvim" }, -- Shows next possible keystrokes
	{ src = "https://github.com/nvim-lualine/lualine.nvim" }, -- Status line
	{ src = "https://github.com/j-hui/fidget.nvim" }, -- better notifications
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- Icons for file types
	{ src = "https://github.com/mrjones2014/smart-splits.nvim" }, -- Better split navigation, including terminal/multiplexer support
})

-- Enable plugins
require("mini.pick").setup()
require("mini.surround").setup()
require("mini.extra").setup()
require("oil").setup()
require("fidget").setup({
	notification = {
		override_vim_notify = true,
	},
})
require("lualine").setup({})
require("nvim-web-devicons").setup()
require("smart-splits").setup()

-- Key bindings
vim.keymap.set({ "n" }, "<leader>f", ":Pick files<CR>")
vim.keymap.set({ "n" }, "<leader>h", ":Pick help<CR>")
vim.keymap.set({ "n" }, "<leader>e", ":Oil<CR>")

-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
