-- Neovim config: Plugins
-- vim: ft=lua ff=unix
--
-- TODO:
-- replace mini.pick with Telescope because it's so much nicer

vim.pack.add({
	{ src = "https://github.com/mini-nvim/mini.nvim" }, -- Collection of several small plugins
	{ src = "https://github.com/stevearc/oil.nvim" }, -- File manager
	{ src = "https://github.com/folke/which-key.nvim" }, -- Shows next possible keystrokes
	{ src = "https://github.com/nvim-lualine/lualine.nvim" }, -- Status line
	{ src = "https://github.com/j-hui/fidget.nvim" }, -- better notifications
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- Icons for file types
	{ src = "https://github.com/mrjones2014/smart-splits.nvim" }, -- Better split navigation, including terminal/multiplexer support
	{ src = "https://github.com/DrKJeff16/wezterm-types" }, -- Wezterm-specific LSP type info

	-- These section below is for Telescope
	{ src = "https://github.com/nvim-lua/plenary.nvim" }, -- Helper plugin for Telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim" }, -- Telescope itself
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" }, -- Telescope UI addons
})

-- Enable plugins
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

require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

-- Enable Telescope extensions if they are installed
pcall(require("telescope").load_extension, "ui-select")

-- Key bindings for Telescope
-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- Shortcut for Oil file manager
vim.keymap.set({ "n" }, "<leader>e", ":Oil<CR>")

-- recommended mappings for smart-splits
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
