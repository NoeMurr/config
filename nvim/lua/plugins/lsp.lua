return {
    { 
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require("lspconfig")

            -- clangd server setup
            lspconfig.clangd.setup({
                    on_attach = function(client, buffnr) 
                        nmap('<A-o>', ':ClangdSwitchSourceHeader<CR>')
                        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {noremap=true, silent=true, buffer=buffnr})
                    end
            })
        end
    },

}
