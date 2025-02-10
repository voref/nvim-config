return {
	-- Mason: Package manager for LSP, DAP, linters, and formatters
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason-LSPConfig: Ensures LSP servers are installed and configured
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- Add LSPs here
				ensure_installed = {
					"lua_ls",
				},
			})
		end,
	},

	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		lazy = false, -- Load immediately
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Setup and configure each LSP

			-- Lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			-- Key mappings for LSP functions
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover info" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
		end,
	},

	-- Mason Tool Installer: Automatically installs formatters and linters
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua", -- Lua formatter
				},
				auto_update = true, -- Automatically update installed tools
			})
		end,
	},
}
