return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        delay = 300,
        icons = {
            mappings = true,
        },
        spec = {
            { "<leader>b", group = "Buffers" },
            { "<leader>c", group = "Code", mode = { "n", "x" } },
            { "<leader>f", group = "Files" },
            { "<leader>h", group = "Git Hunk", mode = { "n", "v" } },
            { "<leader>r", group = "Rename" },
            { "<leader>s", group = "Search" },
            { "<leader>t", group = "Toggle" },
            { "<leader>w", group = "Windows" },
            { "<leader><tab>", group = "Tabs" },
        },
    },
}
