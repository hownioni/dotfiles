return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>gf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[G]et [F]ormatting",
		},
	},
	opts = {
		formatters_by_ft = {
			markdown = { "prettier" },
			lua = { "stylua" },
			python = {
				-- To fix auto-fixable lint errors.
				"ruff_fix",
				-- To run the Ruff formatter.
				"ruff_format",
				-- To organize the imports.
				"ruff_organize_imports",
			},
			sh = { "shellharden", "shfmt" },
			bash = { "shellharden", "shfmt" },
			asm = { "asmfmt" },
			toml = { "pyproject-fmt" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		},
	},
}
