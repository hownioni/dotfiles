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
map("<Esc>", "<cmd>nohlsearch<CR>", "clear search highlights")

-- [[ Copied from LazyVim ]]

-- Move to window using the <ctrl>+hjkl keys
map("<C-h>", "<C-w>h", "go to left window", { remap = true })
map("<C-j>", "<C-w>j", "go to lower window", { remap = true })
map("<C-k>", "<C-w>k", "go to upper window", { remap = true })
map("<C-l>", "<C-w>l", "go to right window", { remap = true })
map("<C-q>", "<C-w>q", "close window", { remap = true })

-- Resize window using <ctrl> arrow keys
map("<C-Up>", "<cmd>resize +2<cr>", "increase window height")
map("<C-Down>", "<cmd>resize -2<cr>", "decrease window height")
map("<C-Left>", "<cmd>vertical resize -2<cr>", "decrease window width")
map("<C-Right>", "<cmd>vertical resize +2<cr>", "increase window width")

-- Move Lines
map("<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", "move down")
map("<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", "move up")
map("<A-j>", "<esc><cmd>m .+1<cr>==gi", "move down", nil, "i")
map("<A-k>", "<esc><cmd>m .-2<cr>==gi", "move up", nil, "i")
map("<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", "move down", nil, "v")
map("<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", "move up", nil, "v")

-- buffers
map("[b", "<cmd>bprevious<cr>", "prev buffer")
map("]b", "<cmd>bnext<cr>", "next buffer")
map("<leader>bb", "<cmd>e #<cr>", "switch to other buffer")
map("<leader>bd", "<cmd>:bd<cr>", "delete buffer and window")
map("<leader>bO", function()
    local current = vim.fn.bufnr()
    for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        if buf.bufnr ~= current then
            vim.cmd("bd " .. buf.bufnr)
        end
    end
end, "close other buffers")

-- diagnostics
map("]d", vim.diagnostic.goto_next, "next diagnostic")
map("[d", vim.diagnostic.goto_prev, "prev diagnostic")

-- quickfix
map("]q", "<cmd>cnext<cr>", "next quickfix item")
map("[q", "<cmd>cprev<cr>", "prev quickfix item")
map("]Q", "<cmd>clast<cr>", "last quickfix item")
map("[Q", "<cmd>cfirst<cr>", "first quickfix item")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "'Nn'[v:searchforward].'zv'", "next search result", { expr = true }, "n")
map("n", "'Nn'[v:searchforward]", "next search result", { expr = true }, "x")
map("n", "'Nn'[v:searchforward]", "next search result", { expr = true }, "o")
map("N", "'nN'[v:searchforward].'zv'", "prev search result", { expr = true }, "n")
map("N", "'nN'[v:searchforward]", "prev search result", { expr = true }, "x")
map("N", "'nN'[v:searchforward]", "prev search result", { expr = true }, "o")

-- save file
map("<C-s>", "<cmd>w<cr><esc>", "save file", nil, { "i", "x", "n", "s" })

--keywordprg
map("<leader>K", "<cmd>norm! K<cr>", "keywordprg")

-- better indenting
map("<", "<gv", "", nil, "v")
map(">", ">gv", "", nil, "v")

-- commenting
map("gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "add comment below")
map("gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "add comment above")

-- toggles
map("<leader>ts", function()
    vim.opt_local.spell = not vim.opt_local.spell
end, "toggle spell")
map("<leader>tl", function()
    vim.wo.relativenumber = not vim.wo.relativenumber
end, "toggle relative numbers")

-- lazy
map("<leader>l", "<cmd>Lazy<cr>", "lazy")

-- new file
map("<leader>fn", "<cmd>enew<cr>", "new file")

-- windows
map("<leader>-", "<C-W>s", "split window below", { remap = true })
map("<leader>|", "<C-W>v", "split window right", { remap = true })
map("<leader>wd", "<C-W>c", "delete window", { remap = true })

-- tabs
map("<leader><tab>l", "<cmd>tablast<cr>", "last tab")
map("<leader><tab>o", "<cmd>tabonly<cr>", "close other tabs")
map("<leader><tab>f", "<cmd>tabfirst<cr>", "first tab")
map("<leader><tab><tab>", "<cmd>tabnew<cr>", "new tab")
map("<leader><tab>]", "<cmd>tabnext<cr>", "next tab")
map("<leader><tab>d", "<cmd>tabclose<cr>", "close tab")
map("<leader><tab>[", "<cmd>tabprevious<cr>", "previous tab")

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Prose writing mode: soft word-wrap + visual-line navigation
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "tex", "plaintex", "text", "rst", "asciidoc" },
    group = vim.api.nvim_create_augroup("prose-mode", { clear = true }),
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.colorcolumn = ""

        -- j/k navigate visual lines; arrow keys intentionally left as logical-line navigation
        local opts = { expr = true, buffer = true }
        vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", opts)
        vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", opts)
        vim.keymap.set("n", "0", "g0", { buffer = true })
        vim.keymap.set("n", "$", "g$", { buffer = true })
        vim.keymap.set("n", "^", "g^", { buffer = true })
    end,
})
