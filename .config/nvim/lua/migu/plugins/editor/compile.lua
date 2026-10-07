return {
    "ej-shafran/compile-mode.nvim",
    version = "^5.0.0",
    keys = {
        { "<leader>cc", "<cmd>Compile<cr>", desc = "compile" },
        { "<leader>cr", "<cmd>Recompile<cr>", desc = "recompile" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "m00qek/baleia.nvim", tag = "v1.3.0", submodules = false },
    },
    config = function()
        ---@module "compile-mode"
        ---@type CompileModeOpts
        vim.g.compile_mode = {
            default_command = {
                python = "python %",
                lua = "lua %",
                javascript = "bun %",
                typescript = "bun %",
                c = "gcc -o %:r % && ./%:r",
                cpp = "g++ -std=c++23 -o %:r % && ./%:r",
                java = "javac % && java %:r",
                go = "go run %",
            },
            ansi_color = { kind = "render", baleia_options = {} },
            bang_expansion = true,
        }
    end,
}
