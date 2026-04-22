return {
    "ej-shafran/compile-mode.nvim",
    version = "^5.0.0",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "m00qek/baleia.nvim",
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
                cpp = "gcc -std=c++23 -o %:r % && ./%:r",
                java = "javac % && java %:r",
                go = "go run %",
            },
            input_word_completion = true,
            baleia_setup = true,
            bang_expansion = true,
            focus_compilation_buffer = true,
        }
    end,
}
