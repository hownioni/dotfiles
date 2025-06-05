return {
    {
        "saghen/blink.cmp",
        event = "VimEnter",
        version = "1.*",
        dependencies = {
            -- Snippet Engine
            {
                "echasnovski/mini.snippets",
                version = false,
                dependencies = { "rafamadriz/friendly-snippets" },
                opts = function()
                    local snips = require("mini.snippets")

                    return {
                        snippets = {
                            snips.gen_loader.from_lang(),
                        },
                    }
                end,
            },
            "folke/lazydev.nvim",
            {
                "micangl/cmp-vimtex",
                dependencies = {
                    "saghen/blink.compat",
                    version = "*",
                    lazy = true,
                    opts = {},
                },
            },
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = "default" },

            appearance = { nerd_font_variant = "mono" },

            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
            },

            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "vimtex", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority
                        score_offset = 100,
                    },
                    vimtex = {
                        name = "vimtex",
                        module = "blink.compat.source",
                        score_offset = 100,
                    },
                },
            },

            snippets = { preset = "mini_snippets" },

            fuzzy = { implementation = "prefer_rust_with_warning" },

            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
    },
}
