return {
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        priority = 49,
        dependencies = {
            "saghen/blink.cmp",
        },
        opts = {},
    },
    {
        -- Markdown table editor: grid + pipe tables (local repo; keymaps under <localleader>t)
        dir = "~/repos/GitHub/tablamd.nvim",
        name = "tablamd.nvim",
        ft = "markdown",
        cmd = "TablaMd",
        opts = {},
    },
}
