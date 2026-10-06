return {
    "tpope/vim-fugitive",
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader>gg", "<cmd>Git<cr>", { desc = "git fugitive" })
    end,
}
