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
Plug( 'theHamsta/nvim-dap-virtual-text' ) -- debugger virtual text

-- telescope
Plug( 'nvim-telescope/telescope.nvim' ) -- Telescope search
Plug( 'nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' } ) -- Telescope fuzzy search for telescope
Plug( 'nvim-telescope/telescope-file-browser.nvim' ) -- file browser in tree view through telescope
Plug( 'nvim-telescope/telescope-dap.nvim' ) -- dap interface with telescope

-- lsp and tree sitter 
Plug( 'nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' } )  -- nvim tree sitter Abstract syntax tree for telescope 

Plug( 'neovim/nvim-lspconfig' ) -- lsp configurations 
Plug( 'mfussenegger/nvim-lint' ) -- linter for nvim

-- git blame inline
Plug( 'APZelos/blamer.nvim' )

-- commment creator
Plug( 'terrortylor/nvim-comment' )

-- auto complete and snippet engine
Plug( 'L3MON4D3/LuaSnip' )
Plug( 'saadparwaiz1/cmp_luasnip' ) 

Plug( 'hrsh7th/cmp-nvim-lsp' )
Plug( 'hrsh7th/cmp-buffer' )
Plug( 'hrsh7th/cmp-path' )
Plug( 'hrsh7th/cmp-cmdline' )
Plug( 'hrsh7th/nvim-cmp' )
--
vim.call('plug#end')

--------------------------------------------
-- Plugin's setups
-- -----------------------------------------
-- lsp configurations
local lspconfig = require("lspconfig")

-- clangd server setup
lspconfig.clangd.setup({
        on_attach = function(client, buffnr) 
                nmap('<A-o>', ':ClangdSwitchSourceHeader<CR>')
        end
})

-- cmp setup
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args) 
            require('luasnip').lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
    --   ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
    --   ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
})

-- dap setup
local dap = require('dap')
require('dap.ext.vscode').load_launchjs()
-- dap.configurations.cpp = {
--   {
--     name = 'Launch',
--     type = 'lldb',
--     request = 'launch',
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--     args = {},
--   },
-- }

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

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
require('telescope').load_extension('dap')

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

-- comment setup
require('nvim_comment').setup({create_mappings = false})

--------------------------------------------
-- Clang format
--------------------------------------------

vmap('<C-k>', ':pyf /usr/share/clang/clang-format.py<cr>') -- format selected lines in visual mode
imap('<C-k>', ':pyf /usr/share/clang/clang-format.py<cr>') -- format current line in insert mode
nmap('<C-k>', ':pyf /usr/share/clang/clang-format.py<cr>') -- format current line in normal mode

-- <C-_> == ctrl + /
vmap('<C-_>', ":'<,'>CommentToggle<CR>")
nmap('<C-_>', ":CommentToggle<CR>")


nmap('t', ':Telescope file_browser<CR>')
nmap('f', ':Telescope find_files<CR>')
nmap('F', ':Telescope buffers<CR>')
nmap('L', ':Telescope live_grep<CR>')
nmap('ca', ':lua vim.lsp.buf.code_action()<CR>') -- code actionf rom lsp (fix-available)

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
