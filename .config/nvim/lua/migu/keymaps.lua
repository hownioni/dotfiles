local function map(keys, func, desc, opts, mode)
    mode = mode or "n"
    local options = { desc = desc }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, keys, func, options)
end

-- [[ Basic Keymaps ]]

-- Clear search
map("<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")

-- [[ Copied from LazyVim ]]

-- Move to window using the <ctrl>+hjkl keys
map("<C-h>", "<C-w>h", "Go to left window", { remap = true })
map("<C-j>", "<C-w>j", "Go to lower window", { remap = true })
map("<C-k>", "<C-w>k", "Go to upper window", { remap = true })
map("<C-l>", "<C-w>l", "Go to right window", { remap = true })
map("<C-q>", "<C-w>q", "Close window", { remap = true })

-- Resize window using <ctrl> arrow keys
map("<C-Up>", "<cmd>resize +2<cr>", "Increase Window Height")
map("<C-Down>", "<cmd>resize -2<cr>", "Decrease Window Height")
map("<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease Window Width")
map("<C-Right>", "<cmd>vertical resize +2<cr>", "Increase Window Width")

-- Move Lines
map("<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", "Move Down")
map("<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", "Move Up")
map("<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move Down", nil, "i")
map("<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move Up", nil, "i")
map("<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", "Move Down", nil, "v")
map("<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", "Move Up", nil, "v")

-- buffers
map("[b", "<cmd>bprevious<cr>", "Prev Buffer")
map("]b", "<cmd>bnext<cr>", "Next Buffer")
map("<leader>bb", "<cmd>e #<cr>", "Switch to Other Buffer")
map("<leader>bd", "<cmd>:bd<cr>", "Delete Buffer and Window")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "'Nn'[v:searchforward].'zv'", "Next Search Result", { expr = true }, "n")
map("n", "'Nn'[v:searchforward]", "Next Search Result", { expr = true }, "x")
map("n", "'Nn'[v:searchforward]", "Next Search Result", { expr = true }, "o")
map("N", "'nN'[v:searchforward].'zv'", "Prev Search Result", { expr = true }, "n")
map("N", "'nN'[v:searchforward]", "Prev Search Result", { expr = true }, "x")
map("N", "'nN'[v:searchforward]", "Prev Search Result", { expr = true }, "o")

-- save file
map("<C-s>", "<cmd>w<cr><esc>", "Save File", nil, { "i", "x", "n", "s" })

--keywordprg
map("<leader>K", "<cmd>norm! K<cr>", "Keywordprg")

-- better indenting
map("<", "<gv", "", nil, "v")
map(">", ">gv", "", nil, "v")

-- commenting
map("gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Below")
map("gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Above")

-- lazy
map("<leader>l", "<cmd>Lazy<cr>", "Lazy")

-- new file
map("<leader>fn", "<cmd>enew<cr>", "New File")

-- windows
map("<leader>-", "<C-W>s", "Split Window Below", { remap = true })
map("<leader>|", "<C-W>v", "Split Window Right", { remap = true })
map("<leader>wd", "<C-W>c", "Delete Window", { remap = true })

-- tabs
map("<leader><tab>l", "<cmd>tablast<cr>", "Last Tab")
map("<leader><tab>o", "<cmd>tabonly<cr>", "Close Other Tabs")
map("<leader><tab>f", "<cmd>tabfirst<cr>", "First Tab")
map("<leader><tab><tab>", "<cmd>tabnew<cr>", "New Tab")
map("<leader><tab>]", "<cmd>tabnext<cr>", "Next Tab")
map("<leader><tab>d", "<cmd>tabclose<cr>", "Close Tab")
map("<leader><tab>[", "<cmd>tabprevious<cr>", "Previous Tab")

-- WhichKey
map("<leader>wk", "<cmd>WhichKey <CR>", "[W]hich[K]ey")

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
