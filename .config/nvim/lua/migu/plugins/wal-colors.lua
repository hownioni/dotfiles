return {
	"mbrea-c/wal-colors.nvim",
	config = function()
		local tweaks = function(colors)
			return {
				StatusLineNC = { fg = colors.foreground, bg = colors.background },
			}
		end
		vim.cmd([[colorscheme mbc]]) -- activate the colorscheme
		require("wal-colors").setup(tweaks, { replace = false })
	end,
	priority = 1000,
}
