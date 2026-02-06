return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        ---@module 'lazydev'
        ---@type lazydev.Config
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "hownioni/Arduino-Nvim",
        branch = "patch-1",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "arduino",
                callback = function()
                    require("Arduino-Nvim")
                end,
            })
        end,
    },
    {
        -- Main LSP Configuration
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            -- Mason must be loaded before dependants
            -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
            {
                "mason-org/mason.nvim",
                ---@module 'mason.settings'
                ---@type MasonSettings
                ---@diagnostic disable-next-line: missing-fields
                opts = {},
            },
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            -- Useful status updates for LSP.
            { "j-hui/fidget.nvim", opts = {} },

            -- Allow extra capabilities provided by blink.cmp
            "saghen/blink.cmp",
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    require("migu.plugins.lsp.keymaps").keymaps(event)
                end,
            })

            -- Diagnostic Config
            -- See :help vim.diagnostic.Opts
            vim.diagnostic.config({
                severity_sort = true,
                float = { border = "rounded", source = "if_many" },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = "󰋽 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                } or {},
                virtual_text = {
                    source = "if_many",
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            })

            ---@class LspServersConfig
            ---@field mason table<string, vim.lsp.Config>
            ---@field others table<string, vim.lsp.Config>
            local servers = {
                --  Add any additional override configuration in the following tables. Available keys are:
                --  - cmd (table): Override the default command used to start the server
                --  - filetypes (table): Override the default list of associated filetypes for the server
                --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
                --  - settings (table): Override the default settings passed when initializing the server.
                --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
                mason = {
                    bashls = {
                        settings = {
                            bashIde = {
                                shellcheckPath = "",
                            },
                        },
                    },
                    clangd = {},
                    ty = {},
                    lua_ls = {
                        settings = {
                            Lua = {
                                completion = {
                                    callSnippet = "Replace",
                                },
                                diagnostics = {
                                    disable = { "missing-fields" },
                                },
                            },
                        },
                    },
                    ruff = {},
                    yamlls = {},
                    marksman = {},
                    asm_lsp = {},
                    taplo = {},
                    texlab = {
                        on_attach = function(_, bufnr)
                            require("migu.plugins.lsp.keymaps").texlab(bufnr)
                        end,
                    },
                    arduino_language_server = {},
                    ts_ls = {},
                    html = {},
                    cssls = {},
                },
                others = {},
            }

            local ensure_installed = vim.tbl_keys(servers.mason or {})
            vim.list_extend(ensure_installed, {
                "stylua",
                "shfmt",
                "shellcheck",
                "shellharden",
                "checkmake",
                "asmfmt",
                "prettier",
            })
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            for server, config in pairs(vim.tbl_extend("keep", servers.mason, servers.others)) do
                if not vim.tbl_isempty(config) then
                    vim.lsp.config(server, config)
                end
            end

            require("mason-lspconfig").setup({
                ensure_installed = {},
                automatic_enable = true,
            })

            if not vim.tbl_isempty(servers.others) then
                vim.lsp.enable(vim.tbl_keys(servers.others))
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client == nil then
                        return
                    end
                    if client.name == "ruff" then
                        -- Disable hover in favor of Pyright
                        client.server_capabilities.hoverProvider = false
                    end
                end,
                desc = "LSP: Disable hover capability from Ruff",
            })
        end,
    },
    require("migu.plugins.lsp.blink-cmp"),
}
