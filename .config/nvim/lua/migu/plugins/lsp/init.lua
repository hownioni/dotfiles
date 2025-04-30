return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"nvim-java/nvim-java",

		-- Useful status updates for LSP.
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				require("migu.plugins.lsp.keymaps").keymaps(event)
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

		local servers = {
			bashls = {
				settings = {
					bashIde = {
						shellcheckPath = "",
					},
				},
			},
			clangd = {},
			pyright = {
				capabilities = (function()
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
					return capabilities
				end)(),
				settings = {
					python = {
						analysis = {
							useLibraryCodeForTypes = true,
							diagnosticServerityOverrides = {
								reportUnusedVariable = "warning",
							},
							typeCheckingMode = "basic",
						},
					},
				},
			},
			lua_ls = {
				-- cmd = {...},
				-- filetypes = { ...},
				-- capabilities = {},
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
			ruff = {},
			yamlls = {},
			marksman = {},
			asm_lsp = {},
			taplo = {},
		}

		require("mason").setup({
			registries = {
				"github:nvim-java/mason-registry",
				"github:mason-org/mason-registry",
			},
		})
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"shfmt",
			"shellcheck",
			"checkmake",
			"shellharden",
			"asmfmt",
			"pyproject-fmt",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for tsserver)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
				jdtls = function()
					require("java").setup({
						-- Your custom jdtls settings goes here
					})

					require("lspconfig").jdtls.setup({
						-- Your custom nvim-java configuration goes here
					})
				end,
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client == nil then
					return
				end
				if client.name == "ruff" then
					-- Disable hover in favor of Pyright
					client.server_capabilities.hoverProvider = false
				end
			end,
			desc = "LSP: Disable hover capability from Ruff",
		})
	end,
}
