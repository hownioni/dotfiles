return {
    -- {
    --     "echasnovski/mini.snippets",
    --     event = "InsertEnter",
    --     version = false,
    --     dependencies = "rafamadriz/friendly-snippets",
    --     opts = function()
    --         local snips = require("mini.snippets")
    --
    --         -- Adjust language patterns
    --         -- Adjust language patterns
    --         local latex_patterns = { "latex/**/*.json", "**/latex.json" }
    --         local lang_patterns = {
    --             tex = latex_patterns,
    --             plaintex = latex_patterns,
    --             -- Recognize special injected language of markdown tree-sitter parser
    --             markdown_inline = { "markdown.json" },
    --         }
    --
    --         return {
    --             snippets = {
    --                 snips.gen_loader.from_lang({ lang_patterns = lang_patterns }),
    --             },
    --         }
    --     end,
    -- },
    {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = "make install_jsregexp",
        dependencies = {
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
    },
    {
        "saghen/blink.cmp",
        event = "VimEnter",
        version = "1.*",
        dependencies = {
            -- Snippet Engine
            -- "echasnovski/mini.snippets",
            "L3MON4D3/LuaSnip",
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
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                menu = {
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind", gap = 1 },
                            { "source_name" },
                        },
                        components = {
                            source_name = {
                                text = function(ctx)
                                    return "[" .. ctx.source_name .. "]"
                                end,
                            },
                        },
                    },
                },
            },
            -- snippets = { preset = "mini_snippets" },
            snippets = { preset = "luasnip" },
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
                        name = "VimTeX",
                        module = "blink.compat.source",
                        score_offset = 100,
                    },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
    },
}
