local Plug = vim.fn['plug#'] 

vim.call('plug#begin')

Plug( 'catppuccin/nvim', { as = 'catppuccin' })

Plug( 'startup-nvim/startup.nvim' ) -- startup screen 

Plug( 'nvim-lua/plenary.nvim' ) -- useful lua functions
--Plug( 'nvim-tree/nvim-tree.lua' ) -- tree view
Plug( 'nvim-tree/nvim-web-devicons' ) -- for file icons

-- Debugger 
Plug( 'mfussenegger/nvim-dap' ) -- Debugger Adapter Protocol
Plug( 'rcarriga/nvim-dap-ui' ) -- Debugger Adapter Protocol Ui
Plug( 'theHamsta/nvim-dap-virtual-text' ) -- debugger virtual text

-- telescope
Plug( 'nvim-telescope/telescope.nvim' ) -- Telescope search
Plug( 'nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' } ) -- Telescope fuzzy search for telescope
Plug( 'nvim-telescope/telescope-file-browser.nvim' ) -- file browser in tree view through telescope
Plug( 'nvim-telescope/telescope-dap.nvim' ) -- dap interface with telescope
Plug( 'nvim-telescope/telescope-ui-select.nvim' )
Plug( 'nvim-telescope/telescope-symbols.nvim' )
--Plug( 'kiyoon/telescope-insert-path.nvim' ) -- telescope action for path
Plug( 'NoeMurr/telescope-insert-path.nvim' ) -- telescope action for path
--Plug( '$HOME/personal-dev/telescope-insert-path.nvim' ) 

-- lsp and tree sitter 
Plug( 'nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' } )  -- nvim tree sitter Abstract syntax tree for telescope 
Plug( 'nvim-treesitter/nvim-treesitter-textobjects' ) -- text object movements

Plug( 'neovim/nvim-lspconfig' ) -- lsp configurations 
Plug( 'mfussenegger/nvim-lint' ) -- linter for nvim
Plug( 'kosayoda/nvim-lightbulb' ) -- code action 

--lua snip for snippets
Plug( 'L3MON4D3/LuaSnip', {tag='v1.2.1',  ['do'] = 'make install_jsregexp'} ) 

-- commment creator
-- Plug( 'terrortylor/nvim-comment' )
Plug( 'tomtom/tcomment_vim' )

-- auto complete and snippet engine
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

-- scartch
Plug( 'mtth/scratch.vim' )

-- csv
Plug( 'chrisbra/csv.vim' )

-- file system
Plug( 'stevearc/oil.nvim' )

Plug( "folke/which-key.nvim" )

vim.call('plug#end')
