LgTerm = nil
LdTerm = nil
IpythonTerm = nil

return {

    "numToStr/FTerm.nvim",

    config = function()
        local ft = require('FTerm')
        ft.setup({})

        -- lazygit
        LgTerm = ft:new({
            ft = 'fterm_lg',
            cmd = { 'lazygit' },
            dimensions = {
                height = 0.9,
                width = 0.9,
            },
        });

        -- lazydocker
        LdTerm = ft:new({
            ft = 'fterm_ld',
            cmd = { 'lazydocker' },
            dimensions = {
                height = 0.9,
                width = 0.9,
            },
        });

        -- lazydocker
        IpythonTerm = ft:new({
            ft = 'fterm_ipython',
            cmd = { 'ipython' },
        });
    end,

    keys = {
        { "<A-i>", function() require('FTerm').toggle() end, desc = "Toggle FTerm terminal" },
        { "<A-i>", function() require('FTerm').toggle() end, desc = "Toggle FTerm terminal",      mode = 't' },

        { "<A-g>", function() LgTerm:toggle() end,           desc = "Toggle LazyGit terminal" },
        { "<A-g>", function() LgTerm:toggle() end,           desc = "Toggle LazyGit terminal",    mode = 't' },

        { "<A-d>", function() LdTerm:toggle() end,           desc = "Toggle LazyDocker terminal" },
        { "<A-d>", function() LdTerm:toggle() end,           desc = "Toggle LazyDocker terminal", mode = 't' },

        { "<A-p>", function() IpythonTerm:toggle() end,      desc = "Toggle ipython terminal" },
        { "<A-p>", function() IpythonTerm:toggle() end,      desc = "Toggle ipython terminal",    mode = 't' },
    }
}
