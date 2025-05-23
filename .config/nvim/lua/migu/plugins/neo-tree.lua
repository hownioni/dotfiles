-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {
		-- 	"3rd/image.nvim",
		-- 	build = false,
		-- 	opts = { processor = "magick_cli" },
		-- },
	},
	lazy = false,
	keys = {
		{ "<C-n>", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
	},
	opts = {
		-- window = {
		-- 	mappings = {
		-- 		["P"] = {
		-- 			"toggle_preview",
		-- 			config = { use_image_nvim = true },
		-- 		},
		-- 		["l"] = "focus_preview",
		-- 		["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
		-- 		["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
		-- 	},
		-- },
		filesystem = {
			window = {
				mappings = {
					["<C-n>"] = "close_window",
				},
			},
		},
	},
}
