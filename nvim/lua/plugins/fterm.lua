local lgTerm = nil
local ldTerm = nil
local IpythonTerm = nil

return {

    "numToStr/FTerm.nvim",

    config = function() 

        local ft = require('FTerm')
        ft.setup({})

        -- lazygit 
        lgTerm = ft:new({ 
            ft = 'fterm_lg', 
            cmd = {'lazygit'}, 
            dimensions = {
                height = 0.9,
                width = 0.9,
            },
        });

        -- lazydocker
        ldTerm = ft:new({ 
            ft = 'fterm_ld', 
            cmd = {'lazydocker'}, 
            dimensions = {
                height = 0.9,
                width = 0.9,
            },
        });

        -- lazydocker
        IpythonTerm = ft:new({ 
            ft = 'fterm_ipython', 
            cmd = {'ipython'}, 
        });
            
    end,

    keys = {
        {"<A-i>", function() require('FTerm').toggle() end, desc = "Toggle FTerm terminal"},
        {"<A-i>", function() require('FTerm').toggle() end, desc = "Toggle FTerm terminal", mode = 't'},

        {"<A-g>", function() lgTerm:toggle() end, desc = "Toggle LazyGit terminal"},
        {"<A-g>", function() lgTerm:toggle() end, desc = "Toggle LazyGit terminal", mode = 't'},

        {"<A-d>", function() ldTerm:toggle() end, desc = "Toggle LazyDocker terminal"},
        {"<A-d>", function() ldTerm:toggle() end, desc = "Toggle LazyDocker terminal", mode = 't'},

        {"<A-p>", function() IpythonTerm:toggle() end, desc = "Toggle ipython terminal"},
        {"<A-p>", function() IpythonTerm:toggle() end, desc = "Toggle ipython terminal", mode = 't'},
    }
}
