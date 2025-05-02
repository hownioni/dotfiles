return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"diff",
				"html",
				"java",
				"javascript",
				"ledger",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "true" } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>nn",
					node_incremental = "<leader>rn",
					scope_incremental = "<leader>rc",
					node_decremental = "<leader>rm",
				},
			},
		},
	},
}
