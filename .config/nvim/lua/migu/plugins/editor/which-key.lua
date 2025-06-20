return {
    "folke/which-key.nvim",
    event = "VimEnter",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = {
        icons = {
            mappings = vim.g.have_nerd_font,
            keys = {},
        },
        spec = {
            { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
            { "<leader>d", group = "[D]ocument" },
            { "<leader>r", group = "[R]ename" },
            { "<leader>s", group = "[S]earch" },
            { "<leader>w", group = "[W]orkspace" },
            { "<leader>t", group = "[T]oggle" },
            { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
        },
    },
}
