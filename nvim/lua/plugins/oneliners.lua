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

    { 'mfussenegger/nvim-lint' },

    { 'romgrk/barbar.nvim' },

    { 'tpope/vim-fugitive' },

    { 'kosayoda/nvim-lightbulb' },

    {
      'stevearc/oil.nvim',
      opts = {},
      -- Optional dependencies
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
