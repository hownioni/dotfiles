return {
    {
        "nvim-mini/mini.snippets",
        event = "InsertEnter",
        version = false,
        dependencies = "rafamadriz/friendly-snippets",
        opts = function()
            local gen_loader = require("mini.snippets").gen_loader

            -- Adjust language patterns
            local latex_patterns = { "my-latex/**/*.json", "**/my-latex.json" }
            local lang_patterns = {
                tex = latex_patterns,
                plaintex = latex_patterns,
                -- Recognize special injected language of markdown tree-sitter parser
                markdown_inline = { "markdown.json" },
            }

            return {
                snippets = {
                    gen_loader.from_lang({ lang_patterns = lang_patterns }),
                },
            }
        end,
    },
    {
        "saghen/blink.cmp",
        event = "VimEnter",
        version = "1.*",
        dependencies = {
            -- Snippet Engine
            "nvim-mini/mini.snippets",
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
            snippets = { preset = "mini_snippets" },
            completion = {
                trigger = {
                    show_in_snippet = false,
                },
                accept = {
                    auto_brackets = {
                        kind_resolution = {
                            blocked_filetypes = { "tex" },
                        },
                    },
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
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                ghost_text = {
                    enabled = true,
                    show_with_menu = false,
                },
            },
            signature = { enabled = true },
            fuzzy = {
                implementation = "prefer_rust_with_warning",
                sorts = {
                    "exact",
                    "score",
                    "sort_text",
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                per_filetype = {
                    lua = { inherit_defaults = true, "lazydev" },
                    tex = { inherit_defaults = true, "vimtex" },
                },
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
                        fallbacks = { "buffer" },
                    },
                    buffer = {
                        score_offset = -10,
                    },
                },
            },
            appearance = { nerd_font_variant = "mono" },
        },
        opts_extend = { "sources.default" },
    },
}
