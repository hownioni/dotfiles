local opt = vim.o

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.pumheight = 10
opt.pumblend = 10
opt.showtabline = 1
opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Autocomplete
opt.wildmode = "longest:full,full"
opt.completeopt = "menu,menuone,noselect"
opt.inccommand = "split"

-- Backspace
opt.backspace = "indent,eol,start"

-- Cursor
opt.virtualedit = "block"
opt.cursorline = true
opt.startofline = true

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Mouse
opt.mouse = "a"

-- Scroll & Wrap
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.whichwrap = "bs<>[]hl"
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Split windows
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

-- Statusline
opt.laststatus = 3
opt.showmode = false
vim.opt.fillchars:append("eob: ")
vim.opt.fillchars:append({
    stl = " ",
})
opt.formatoptions = "jcroqlnt"

-- Tabs & indentation
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.shiftround = true
opt.smartindent = false

-- Time
opt.timeoutlen = 300
opt.updatetime = 250

-- Misc.
opt.swapfile = false -- turn off swapfile
opt.backup = false
opt.undofile = true
opt.title = true
opt.confirm = true
opt.breakindent = true
vim.schedule(function()
    opt.clipboard = "unnamedplus"
end)
opt.autowrite = true
vim.opt.iskeyword:append("-")
vim.opt.shortmess:append("I")
