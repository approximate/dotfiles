-- Plugins
vim.pack.add({
	{ src = "https://github.com/mini-nvim/mini.nvim" }, -- Collection of several small plugins
	{ src = "https://github.com/stevearc/oil.nvim" }, -- File manager
	{ src = "https://github.com/folke/which-key.nvim" }, -- Shows next possible keystrokes
	{ src = "https://github.com/nvim-lualine/lualine.nvim" }, -- Status line
	{ src = "https://github.com/j-hui/fidget.nvim" }, -- better notifications
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- Icons for file types
})

-- Enable plugins
require("mini.pick").setup()
require("oil").setup()
require("fidget").setup({
	notification = {
		override_vim_notify = true,
	},
})
require("lualine").setup({})
require("nvim-web-devicons").setup()

-- Key bindings
vim.keymap.set({ "n" }, "<leader>f", ":Pick files<CR>")
vim.keymap.set({ "n" }, "<leader>h", ":Pick help<CR>")
vim.keymap.set({ "n" }, "<leader>e", ":Oil<CR>")
