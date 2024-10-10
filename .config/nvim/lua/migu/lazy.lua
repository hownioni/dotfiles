local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({{ import = "migu.plugins" }})

local tweaks = function(colors)
    return {
        StatusLineNC = {fg = colors.foreground, bg = colors.background},
    }
end

require("wal-colors").setup(tweaks, { replace = false })
