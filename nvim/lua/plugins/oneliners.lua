-- in this file there are all the plugins that do not require any configuration.
-- To avoid a great ploriferation of files in this folder the onliner will be here.
return { 
    { 'nvim-lua/plenary.nvim' },

    { 'nvim-tree/nvim-web-devicons' },

    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
    },

    { 'powerman/vim-plugin-AnsiEsc' },

    { 'MunifTanjim/nui.nvim' },

    {
        'romgrk/barbar.nvim',
        dependencies = {
          'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {},
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },

    { 'tpope/vim-fugitive' },

    { 
        'kosayoda/nvim-lightbulb',
        opts = { 
            autocmd = { enabled = true }, 
            float = { enabled = true },
            sign = { enabled = false },
        },
    },

    {
      'stevearc/oil.nvim',
      opts = {},
      -- Optional dependencies
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
