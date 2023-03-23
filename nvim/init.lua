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

Plug( 'startup-nvim/startup.nvim' ) -- startup screen 

Plug( 'nvim-lua/plenary.nvim' ) -- useful lua functions
Plug( 'nvim-tree/nvim-web-devicons' ) -- for file icons
Plug( 'nvim-tree/nvim-tree.lua' ) -- tree view

-- Debugger 
Plug( 'mfussenegger/nvim-dap' ) -- Debugger Adapter Protocol
Plug( 'rcarriga/nvim-dap-ui' ) -- Debugger Adapter Protocol Ui
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

Plug( 'tpope/vim-fugitive' ) -- git support
--
Plug( 'powerman/vim-plugin-AnsiEsc' )

-- modes
Plug( 'Iron-E/nvim-libmodal' )

-- bartab
Plug( 'romgrk/barbar.nvim' )

vim.call('plug#end')

--------------------------------------------
-- Plugin's setups
-- -----------------------------------------
require('startify_setup') -- start screen
require('lspconfig_setup')
require('cmp_setup') -- autocomplete plugin
require('dap_setup') -- debugger adapter
require('telescope_setup')
require('nvim_comment_setup') -- allow me to autocomment
require('barbar_setup') -- buffer bar
require('themes_setup') -- themes

require('keymaps')

require('vim_options')
--------------------------------------------
-- EOF
--------------------------------------------
