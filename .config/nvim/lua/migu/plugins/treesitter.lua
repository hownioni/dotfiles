return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
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
					-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
					--  If you are experiencing weird indenting issues, add the language to
					--  the list of additional_vim_regex_highlighting and disabled languages for indent.
					additional_vim_regex_highlighting = { "ruby" },
				},
				indent = { enable = false, disable = {} },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<leader>nn",
						node_incremental = "<leader>ni",
						scope_incremental = "<leader>nc",
						node_decremental = "<leader>nd",
					},
				},
			})
		end,
	},
	{ "andis-sprinkis/lf-vim", event = { "BufReadPre lfrc" } },
}
