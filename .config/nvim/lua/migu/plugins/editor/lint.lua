return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        {
            "<leader>gl",
            function()
                require("lint").try_lint()
            end,
            desc = "[G]et [L]inting",
        },
    },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            bash = { "shellcheck" },
            sh = { "shellcheck" },
            make = { "checkmake" },
        }

        lint.linters.shellcheck.args = {
            "-x",
            "--format",
            "json1",
            "-",
        }

        -- Create autocommand which carries out the actual linting
        -- on the specified events.
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("lint", { clear = true }),
            callback = function()
                -- Only run the linter in buffers that you can modify in order to
                -- avoid superfluous noise, notably within the handy LSP pop-ups that
                -- describe the hovered symbol using Markdown.
                if vim.bo.modifiable then
                    lint.try_lint()
                end
            end,
        })
    end,
}
