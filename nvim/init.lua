-------------------------------------------
-- Requirements
-- -----------------------------------------
require('utils')

--------------------------------------------
-- Plugins
-- -----------------------------------------
local Plug = vim.fn['plug#'] 

vim.call('plug#begin')

Plug( 'catppuccin/nvim', { as = 'catppuccin' })

Plug( 'nvim-lua/plenary.nvim' ) -- useful lua functions
Plug( 'nvim-tree/nvim-web-devicons' ) -- for file icons
Plug( 'nvim-tree/nvim-tree.lua' ) -- tree view

-- Debugger 
Plug( 'mfussenegger/nvim-dap' ) -- Debugger Adapter Protocol
Plug( 'rcarriga/nvim-dap-ui' ) -- Debugger UI

-- telescope
Plug( 'nvim-telescope/telescope.nvim' ) -- Telescope search
Plug( 'nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' } ) -- Telescope fuzzy search for telescope
Plug( 'nvim-telescope/telescope-file-browser.nvim' ) -- file browser in tree view through telescope

-- lsp and tree sitter 

Plug( 'nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' } )  -- nvim tree sitter Abstract syntax tree for telescope 

Plug( 'neovim/nvim-lspconfig' ) -- lsp configurations 
Plug( 'mfussenegger/nvim-lint' ) -- linter for nvim

-- autocompletion 
Plug( 'ms-jpq/coq_nvim', { branch = 'coq' } );
Plug( 'ms-jpq/coq.artifacts', { branch = 'artifacts' } );
Plug( 'ms-jpq/coq.thirdparty', { branch = '3p' } );

-- git blame inline
Plug( 'APZelos/blamer.nvim' )

vim.call('plug#end')

--------------------------------------------
-- Plugin's setups
-- -----------------------------------------
-- lsp configurations
lspconfig = require("lspconfig")

-- clangd server setup
lspconfig.clangd.setup({
        on_attach = function(client, buffnr) 
                nmap('<A-o>', ':ClangdSwitchSourceHeader<CR>')
        end
})

-- telescope & extensions
require("telescope").setup({
    defaults = {
             path_display = {
                    shorten = 2
             },
             initial_mode = 'normal'
        },
    pickers = {
        buffers = {
            mappings = {
                n = {
                    ['d'] = require('telescope.actions').delete_buffer
                }
            }
        },
        find_files = {
            initial_mode = 'insert'
        },
        live_grep = {
            initial_mode = 'insert'
        }
    }
})

require("telescope").load_extension('fzf')
require("telescope").load_extension('file_browser')

-- nvim-tree
require('nvim-tree').setup({ 
    sync_root_with_cwd = true, 
    actions = {
        change_dir = {
            global = true
        }
    },
    view = {
        mappings = {
            list = {
                 { key = '<CR>', action = 'cd' },
                 { key = '<Space>', action = 'preview' }
             }
        }
    }
})

-- themes
require('catppuccin').setup({transparent_background = true})

--------------------------------------------
-- Clang format
--------------------------------------------

vmap('<C-K>', ':pyf /usr/share/clang/clang-format.py<cr>')
imap('<C-K>', ':pyf /usr/share/clang/clang-format.py<cr>')

nmap('t', ':Telescope file_browser<CR>')
nmap('f', ':Telescope find_files<CR>')
nmap('F', ':Telescope buffers<CR>')
nmap('L', ':Telescope live_grep<CR>')

--------------------------------------------
-- Vim options
--------------------------------------------

-- Status bar only in last window: in other is just a
-- divider
vim.opt.laststatus = 0
vim.api.nvim_set_hl(0 , 'Statusline', {link = 'Normal'})
vim.api.nvim_set_hl(0 , 'StatuslineNC', {link = 'Normal'})
local str = string.rep('-', vim.api.nvim_win_get_width(0))
vim.opt.statusline = str

vim.opt.mouse = 'a' -- mouse in all modes

vim.cmd.colorscheme "catppuccin"
vim.opt.listchars = {lead = '·', trail = '·', tab = '|·>' }
vim.opt.list = true -- show trailing and end character
vim.opt.number = true -- show line number
vim.opt.relativenumber = true -- show line number as relative 
vim.opt.expandtab = true -- convert tab to spaces
vim.opt.tabstop = 4 -- tab = 4 spaces
vim.opt.shiftwidth = 0 -- forced to be the same as tabstop 
vim.opt.autochdir = true -- working directory following the current buffer

-- Global plugin options
vim.g.blamer_enabled = 1
--------------------------------------------
-- EOF
--------------------------------------------
