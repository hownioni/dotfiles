return {
    "sindrets/diffview.nvim",
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "diffview open" },
        { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "file history" },
    },
    config = function()
        local actions = require("diffview.actions")
        require("diffview").setup({
            keymaps = {
                view = {
                    { "n", "<leader>e",  false },
                    { "n", "<leader>b",  false },
                    { "n", "<leader>ge", actions.focus_files,  { desc = "focus file panel" } },
                    { "n", "<leader>gp", actions.toggle_files, { desc = "toggle file panel" } },
                },
                file_panel = {
                    { "n", "<leader>e",  false },
                    { "n", "<leader>b",  false },
                    { "n", "<leader>ge", actions.focus_files,  { desc = "focus file panel" } },
                    { "n", "<leader>gp", actions.toggle_files, { desc = "toggle file panel" } },
                },
            },
        })
    end,
}
