return {
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      keys = {
          {'<F1>', ':WhichKey<CR>'}, -- help keybindings
      },
      opts = {}
    },

    {
      -- "folke/todo-comments.nvim",
      "ynhhoJ/todo-comments.nvim", -- temporary until new updateds on todo-comments
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        search = {
            command = "rg",
            args = {
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
            },
            pattern = [[(KEYWORDS)(?:\(.+\))?:]], -- ripgrep regex
            -- pattern = [[\b(KEYWORDS)\b]], -- ripgrep regex
            -- match pattern like TODO(optional): something
          },
      },
      highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[(KEYWORDS)\s*(\([^\)]*\))?:]],
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
    },

    {
     "folke/trouble.nvim",
     dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
