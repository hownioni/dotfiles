return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			bash = { "shellcheck", "shellharden" },
			sh = { "shellcheck", "shellharden" },
			javascript = { "eslint_d" },
			python = { "ruff" },
		}
	end,
}
