return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "bash",
                "bibtex",
                "c",
                "cpp",
                "diff",
                "gitignore",
                "haskell",
                "html",
                "java",
                "javascript",
                "json",
                "ledger",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            },
            ignore_install = { "latex" },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "ruby" },
            },
            indent = { enable = true, disable = { "true" } },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>nn",
                    node_incremental = "<leader>nn",
                    scope_incremental = false,
                    node_decremental = "<leader>nd",
                },
            },
        },
    },
}
