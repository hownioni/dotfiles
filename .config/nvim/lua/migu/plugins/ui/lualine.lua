return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        config = function()
            ---@param plugin string The name of the plugin (e.g., "nvim-treesitter")
            ---@return boolean True if the plugin is loaded, false otherwise
            local function is_plugin_loaded(plugin)
                return vim.tbl_get(require("lazy.core.config"), "plugins", plugin, "_", "loaded") ~= nil
            end
            ---@type string
            local theme
            if is_plugin_loaded("wal_colors.nvim") then
                theme = "pywal"
            elseif is_plugin_loaded("base16-nvim") then
                theme = "base16"
            else
                theme = "auto"
            end
            require("lualine").setup({
                options = { theme = theme },
            })
        end,
    },
}
