return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
            })

            -- Enable Telescope extensions if they are installed
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")

            -- See `:help telescope.builtin`
            local builtin = require("telescope.builtin")

            -- Search
            vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "search current word" })
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "search by grep" })
            vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "search diagnostics" })
            vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "search resume" })
            vim.keymap.set("n", "<leader>s/", function()
                builtin.live_grep({
                    grep_open_files = true,
                    prompt_title = "Live Grep in Open Files",
                })
            end, { desc = "search in open files" })

            vim.keymap.set("n", "<leader>/", function()
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end, { desc = "fuzzy search in current buffer" })

            -- Files
            vim.keymap.set("n", "<leader>fs", builtin.find_files, { desc = "find files" })
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "recent files" })
            vim.keymap.set("n", "<leader>fc", function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end, { desc = "Neovim config files" })

            -- Help
            vim.keymap.set("n", "<leader>?h", builtin.help_tags, { desc = "help tags" })
            vim.keymap.set("n", "<leader>?k", builtin.keymaps, { desc = "keymaps" })
            vim.keymap.set("n", "<leader>?t", builtin.builtin, { desc = "Telescope pickers" })

            -- Buffers
            vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "find open buffers" })

            -- Git
            vim.keymap.set("n", "<leader>gs", builtin.git_status,   { desc = "git status" })
            vim.keymap.set("n", "<leader>gc", builtin.git_commits,  { desc = "git commits" })
            vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "git branches" })
        end,
    },
}
