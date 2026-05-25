return {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufNewFile" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "grf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = "",
            desc = "format buffer",
        },
        {
            "<leader>tf",
            function()
                vim.g.disable_autoformat = not vim.g.disable_autoformat
                vim.notify(vim.g.disable_autoformat and "Autoformat off" or "Autoformat on")
            end,
            desc = "toggle autoformat",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },

            python = {
                -- To fix auto-fixable lint errors.
                "ruff_fix",
                -- To run the Ruff formatter.
                "ruff_format",
                -- To organize the imports.
                "ruff_organize_imports",
            },

            sh = { "shellharden", "shfmt" },
            bash = { "shellharden", "shfmt" },

            asm = { "asmfmt" },

            markdown = { "prettier" },
            tex = { "latexindent" },

            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            vue = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
        },
        formatters = {
            stylua = {
                args = { "--indent-type", "Spaces", "-" },
            },
            shfmt = {
                args = { "-ci", "-bn" },
            },
            latexindent = {
                args = { "-m", "-l" },
            },
        },
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat then
                return nil
            end
            local disable_filetypes = { c = true, cpp = true }
            if disable_filetypes[vim.bo[bufnr].filetype] then
                return nil
            else
                return {
                    timeout_ms = 2500,
                    lsp_format = "fallback",
                }
            end
        end,
    },
}
