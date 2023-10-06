require'nvim-treesitter.configs'.setup {
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        -- ["gf"] = "@function.outer",
        -- ["gc"] = { query = "@class.outer", desc = "Next class start" },
        -- --
        -- -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
        -- ["]o"] = "@loop.*",
        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        -- ["gs"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
        -- ["gs"] = { query = "@block", query_group = "locals", desc = "Next block" },
        ["gs"] = "@block.outer",
        -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
      },
      goto_next_end = {
        -- ["]M"] = "@function.outer",
        -- ["]["] = "@class.outer",
        -- ["ge"] = { query = "@block", query_group = "locals", desc = "Next scope" },
        ["ge"] = "@block.outer"
      },
      goto_previous_start = {
        -- ["[m"] = "@function.outer",
        -- ["[["] = "@class.outer",
        ["gS"] = { query = "@block", query_group = "locals", desc = "Next scope" },
      },
      goto_previous_end = {
        -- ["[M"] = "@function.outer",
        -- ["[]"] = "@class.outer",
        ["gE"] = { query = "@block", query_group = "locals", desc = "Next scope" },
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      -- goto_next = {
      --   ["]d"] = "@conditional.outer",
      -- },
      -- goto_previous = {
      --   ["[d"] = "@conditional.outer",
      -- }
    },
  },
}
