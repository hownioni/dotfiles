return {
    {
        -- Autopairs
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        -- Indent line
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
    {
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        "echasnovski/mini.ai",
        opts = { n_lines = 500 },
    },
    {
        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        "echasnovski/mini.surround",
        opts = {},
    },
    {
        "nmac427/guess-indent.nvim",
        opts = {},
    },
}
