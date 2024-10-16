local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = augroup("kickstart-highlight-yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})
