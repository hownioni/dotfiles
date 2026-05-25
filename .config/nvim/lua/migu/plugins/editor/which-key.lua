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
            { "<leader>c", group = "Compile" },
            { "<leader>f", group = "Files" },
            { "<leader>g",  group = "Git" },
            { "<leader>gh", group = "Hunk", mode = { "n", "v" } },
            { "<leader>s", group = "Search" },
            { "<leader>t", group = "Toggle" },
            { "<leader>w", group = "Windows" },
            { "<leader>x", group = "Lists" },
            { "<leader>?", group = "Help" },
            { "<leader><tab>", group = "Tabs" },
        },
    },
}
