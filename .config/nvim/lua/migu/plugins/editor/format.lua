return {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufNewFile" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>gf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = "",
            desc = "[G]et [F]ormatting",
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
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = { c = true, cpp = true }
            if disable_filetypes[vim.bo[bufnr].filetype] then
                return nil
            else
                return {
                    timeout_ms = 500,
                    lsp_format = "fallback",
                }
            end
        end,
    },
}
