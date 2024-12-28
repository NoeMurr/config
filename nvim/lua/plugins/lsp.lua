return {
    {
        'neovim/nvim-lspconfig',
    },
    {
        "lvimuser/lsp-inlayhints.nvim",
        opts = {}
    },
    {
        "williamboman/mason.nvim",
        opts = {}
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            local mlc = require("mason-lspconfig")
            mlc.setup()
            mlc.setup_handlers({
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                    --print(string.format("lsp server: %s installed", server_name))
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                ["clangd"] = function()
                    require("lspconfig").clangd.setup({
                        on_attach = function(client, buffnr)
                            nmap('<A-o>', ':ClangdSwitchSourceHeader<CR>')
                            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
                                noremap = true,
                                silent = true,
                                buffer =
                                    buffnr
                            })
                        end
                    })
                end,

                ["rust_analyzer"] = function()
                    require("lspconfig").rust_analyzer.setup({
                        on_attach = function(client, buffnr)
                            require('lsp-inlayhints').on_attach(client, buffnr)
                            require('lsp-inlayhints').show()
                        end
                    })
                end,

                ["lua_ls"] = function()
                    -- print("lua_ls installed")
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    }
                end,

                ['pest_ls'] = function()
                    require('pest-vim').setup {}
                end,
            })
        end
    },
}
