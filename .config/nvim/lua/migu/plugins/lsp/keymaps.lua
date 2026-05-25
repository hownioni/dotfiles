return {
    keymaps = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local telescope = require("telescope.builtin")

        -- Find references for the word under your cursor.
        -- gr* is Neovim 0.11+'s standard LSP keymap prefix. The r stands for
        -- "refactor" — chosen over gl ("language") because gr was a free
        -- namespace with no planned alternative use.
        -- https://github.com/neovim/neovim/pull/28650
        map("grr", telescope.lsp_references, "references")
        map("gri", telescope.lsp_implementations, "implementation")
        map("grd", telescope.lsp_definitions, "definition")
        map("grD", vim.lsp.buf.declaration, "declaration")
        map("grt", telescope.lsp_type_definitions, "type definition")
        map("gre", vim.diagnostic.open_float, "diagnostics float")
        map("<leader>sy", telescope.lsp_document_symbols, "document symbols")
        map("<leader>sW", telescope.lsp_dynamic_workspace_symbols, "workspace symbols")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
                end,
            })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "toggle inlay hints")
        end
    end,
    texlab = function(bufnr)
        vim.keymap.set(
            "n",
            "<localleader>K",
            "<plug>(vimtex-doc-package)",
            { desc = "Vimtex Docs", silent = true, buffer = bufnr }
        )
    end,
}
