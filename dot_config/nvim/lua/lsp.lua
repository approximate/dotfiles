-- ------------------------
-- LSP configuration
-- ------------------------
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" }, -- LSP configuration files
	{ src = "https://github.com/mason-org/mason.nvim" }, -- Mason (LS management)
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" }, -- Helper plugins for Mason/LSP
})

-- Mason helps with vim-based LSP server management
require("mason").setup()

-- Make sure we always have LSP for Lua and Bash.
-- mason-lspconfig also automatically enables installed LSP servers,
-- which means we don't have to call vim.lsp.enable() anymore.
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "bashls" },
})

-- Fix Lua warnings/errors by adding Neovim runtime to the library
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

-- Enable LSP-based completions
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client ~= nil then
			if client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			end
		end
	end,
})

-- Key bindings for LSP-based operations
vim.keymap.set({ "n" }, "<leader>lf", vim.lsp.buf.format, { desc = "Reformat the buffer" })
