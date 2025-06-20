return {
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_quickfix_mode = 0
            vim.o.conceallevel = 1
            vim.g.tex_conceal = "abdmg"
            vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }

            -- if not vim.g.window_id then
            --     vim.g.window_id = vim.fn.system({ "xdotool", "getactivewindow" })
            -- end
            --
            -- vim.api.nvim_create_autocmd("User", {
            --     group = vim.api.nvim_create_augroup("vimtex_event_focus", { clear = true }),
            --     pattern = "VimtexEventView",
            --     callback = function()
            --         vim.uv.sleep(200)
            --         vim.system({ "xdotool", "windowfocus", vim.g.window_id })
            --         vim.api.nvim__redraw({ flush = true })
            --     end,
            -- })
        end,
    },
    {
        "micangl/cmp-vimtex",
        opts = {},
    },
}
