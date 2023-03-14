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
Plug( 'simrat39/rust-tools.nvim' ) -- rust analyzer

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

-- syntax highlight for pest peg grammar
Plug( 'pest-parser/pest.vim' )

-- modes
Plug( 'Iron-E/nvim-libmodal' )

-- bartab
Plug( 'romgrk/barbar.nvim' )

vim.call('plug#end')

--------------------------------------------
-- Plugin's setups
-- -----------------------------------------
-- startup screen configuration
-- getting the startify theme settings for modification
startify_settings = require('startup.themes.startify')

startify_settings.body = startify_settings.body_2
startify_settings.parts = {'header', 'body', 'bookmarks'}

require('startup').setup(startify_settings)

-- lsp configurations
local lspconfig = require("lspconfig")

-- clangd server setup
lspconfig.clangd.setup({
        on_attach = function(client, buffnr) 
            nmap('<A-o>', ':ClangdSwitchSourceHeader<CR>')
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {noremap=true, silent=true, buffer=buffnr})
        end
})

-- rust tools 
lspconfig.rust_analyzer.setup({})

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
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
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
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '/home/noemurr/.vscode/extensions/ms-vscode.cpptools-1.14.3-linux-x64/debugAdapters/bin/OpenDebugAD7',
}

local conf = {
    {
    name = "Launch CPP",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', get_project_root_or_cwd() .. '/', 'file')
    end,
    args = function() 
        local arg_string = vim.fn.input('arguments [empty for none]: ')
        return vim.fn.split(arg_string, " ", true)
    end,
    cwd = function() return get_project_root_or_cwd() end,
    stopAtEntry = true,
    setupCommands = {
        { 
            text = '-enable-pretty-printing',
            description =  'enable pretty printing',
            ignoreFailures = false 
        },
    },
  },
}

dap.configurations.cpp = conf;

require('dapui').setup()

-- telescope & extensions
require("telescope").setup({
    defaults = {
        path_display = {
            "smart"
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
        },
    },
})

require("telescope").load_extension('fzf')
require("telescope").load_extension('file_browser')
require('telescope').load_extension('dap')

--- themes
require('catppuccin').setup({transparent_background = true})

-- comment setup
require('nvim_comment').setup({
    line_mapping = '<C-_>',
})

-- bartab
require('bufferline').setup()

--------------------------------------------
-- Modes
--------------------------------------------

function EnterResizeMode() 

    local resizeKeyMaps = {
        j = 'resize -1',
        k = 'resize +1',
        h = 'vertical resize -1',
        l = 'vertical resize +1',
        w = 'winc w',
        W = 'winc W',
        ['='] = 'resize =',
    }

    require('libmodal').mode.enter('RESIZE', resizeKeyMaps)
end

nmap('W', ':lua EnterResizeMode()<CR>')
--------------------------------------------
-- Settings
--------------------------------------------
nmap('{', 'o<ESC>')
nmap('}', 'O<ESC>')

nmap('pf', ':lua require("telescope.builtin").find_files( { cwd = "' .. get_project_root_or_cwd() .. '" } )<CR>')
nmap('pL', ':lua require("telescope.builtin").live_grep( { cwd = "' .. get_project_root_or_cwd() .. '" } )<CR>')
nmap('pt', ':lua require("telescope").extensions.file_browser.file_browser( { cwd = "' .. get_project_root_or_cwd() .. '" } )<CR>')

nmap('t', ':Telescope file_browser<CR>')
nmap('f', ':Telescope find_files<CR>')
nmap('F', ':Telescope buffers<CR>')
nmap('L', ':Telescope live_grep<CR>')
nmap('ca', ':lua vim.lsp.buf.code_action()<CR>') -- code actionf rom lsp (fix-available)

-- dap bindings
nmap('<F5>', ':Telescope dap configurations<CR>')
nmap('<F6>', ':DapToggleBreakpoint<CR>') 
nmap('<F7>', ':lua require("dapui").toggle()<CR>') 
nmap('<F9>', ':DapContinue<CR>') 
nmap('<F10>', ':DapStepOver<CR>') 
nmap('<F11>', ':DapStepInto<CR>') 
nmap('<F12>', ':DapStepOut<CR>') 

-- mapping for moving lines 
-- normal
nmap('J', ':m +1<CR>') -- move up one line
nmap('K', ':m -2<CR>') -- move down one line

-- visual
vmap('J', ':m +1 | gv<CR>') -- move up one line
vmap('K', ':m -2 | gv<CR>') -- move down one line the gv commands is used for resetting the visual selection

-- diagnostic float
nmap('<A-d>', ':lua vim.diagnostic.open_float()<CR>')

--------------------------------------------
-- Vim options
--------------------------------------------

-- Status bar only in last window: in other is just a
-- divider
vim.opt.laststatus = 3
vim.api.nvim_set_hl(0 , 'Statusline', {link = 'Normal'})
vim.opt.statusline = "%{expand('%:p')} %= %l,%c %p%%"

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
vim.opt.splitright = true -- open new split on right instead of left
vim.opt.spell = true -- spell checking
vim.opt.spelllang=en_us -- english

-- Global plugin options
vim.g.blamer_enabled = 1
vim.g.blamer_show_in_visual_mode = 0

--------------------------------------------
-- EOF
--------------------------------------------
