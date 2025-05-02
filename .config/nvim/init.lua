-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- Set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { expr = true }) -- Makes space do nothing

vim.g.have_nerd_font = true

require("migu.options")
require("migu.keymaps")
require("migu.lazy")
