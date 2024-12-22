return {
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        ft = { 'rust' },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap",
            "lvimuser/lsp-inlayhints.nvim",
        },
        config = function()
            vim.g.rustaceanvim = {
                -- Plugin configuration
                tools = {
                },
                -- LSP configuration
                server = {
                    on_attach = function(client, bufnr)
                        -- Hover actions
                        vim.keymap.set("n", "<C-space>", function() vim.cmd.RustLsp('hover', 'actions') end,
                            { buffer = bufnr })
                        -- Code action groups

                        -- lsp-inlayhints
                        require('lsp-inlayhints').on_attach(client, bufnr)
                        require('lsp-inlayhints').show()
                    end,
                    settings = {
                        -- rust-analyzer language server configuration
                        ['rust-analyzer'] = {
                        },
                    },
                },
                -- DAP configuration
                dap = {
                },
            }
        end
    },

    {
        'pest-parser/pest.vim',
        ft = 'pest',
        build = "cargo install pest-language-server",
        opts = {},
    },
}
