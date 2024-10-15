local map = vim.keymap.set
return {
    keymaps = function()
        map('n', 'K', vim.lsp.buf.hover, { desc = "Hover"})
        map('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition"})
        map('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration"})
        map('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation"})
        map('n', '<leader>D', vim.lsp.buf.type_definition, { desc = "Go to type definition"})
        map('n', '<leader>sh', vim.lsp.buf.signature_help, { desc = "Show signature help"})
        map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder"})
        map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder"})
        map('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { desc = "List workspace folders" })
        map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code actions" })
        map('n', 'gr', vim.lsp.buf.references, { desc = "Show references" })
    end
}
