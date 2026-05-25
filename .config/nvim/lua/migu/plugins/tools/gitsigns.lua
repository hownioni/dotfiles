return {
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end, { desc = "next git [c]hange" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end, { desc = "prev git [c]hange" })

                -- Actions
                -- visual mode
                map("v", "<leader>ghs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "git stage hunk" })
                map("v", "<leader>ghr", function()
                    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "git reset hunk" })
                -- normal mode
                map("n", "<leader>ghs", gitsigns.stage_hunk,   { desc = "git stage hunk" })
                map("n", "<leader>ghr", gitsigns.reset_hunk,   { desc = "git reset hunk" })
                map("n", "<leader>ghS", gitsigns.stage_buffer, { desc = "git stage buffer" })
                map("n", "<leader>ghR", gitsigns.reset_buffer, { desc = "git reset buffer" })
                map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "git preview hunk" })
                map("n", "<leader>ghb", gitsigns.blame_line,   { desc = "git blame line" })
                map("n", "<leader>ghd", gitsigns.diffthis,     { desc = "git diff against index" })
                map("n", "<leader>ghD", function()
                    gitsigns.diffthis("@")
                end, { desc = "git diff against last commit" })
                -- Toggles
                map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "toggle git blame" })
                map("n", "<leader>tD", gitsigns.preview_hunk_inline,       { desc = "toggle git show deleted" })
            end,
        },
    },
}
