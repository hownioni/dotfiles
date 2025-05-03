-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		{
			"3rd/image.nvim",
			build = false,
			opts = { processor = "magick_cli" },
		},
	},
	cmd = "Neotree",
	keys = {
		{ "<C-n>", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
	},
	init = function()
		-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
		-- because `cwd` is not set up properly.
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
			desc = "Start Neo-tree with directory",
			once = true,
			callback = function()
				if package.loaded["neo-tree"] then
					return
				else
					local stats = vim.uv.fs_stat(vim.fn.argv(0))
					if stats and stats.type == "directory" then
						require("neo-tree")
					end
				end
			end,
		})
	end,
	opts = {
		window = {
			mappings = {
				["P"] = {
					"toggle_preview",
					config = { use_image_nvim = true },
				},
				["l"] = "focus_preview",
				["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
				["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
			},
		},
		filesystem = {
			window = {
				mappings = {
					["<C-n>"] = "close_window",
				},
			},
		},
	},
}
