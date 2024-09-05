local lgTerm = nil

return {

    "numToStr/FTerm.nvim",

    config = function() 

        local ft = require('FTerm')
        ft.setup({})

        lgTerm = ft:new({ 
            ft = 'fterm_lg', 
            cmd = {'lazygit'}, 
            dimensions = {
                height = 0.9,
                width = 0.9,
            },
        });
    end,

    keys = {
        {"<A-i>", function() require('FTerm').toggle() end, desc = "Toggle FTerm terminal"},
        {"<A-i>", function() require('FTerm').toggle() end, desc = "Toggle FTerm terminal", mode = 't'},

        {"<A-g>", function() lgTerm:toggle() end, desc = "Toggle LazyGit terminal"},
        {"<A-g>", function() lgTerm:toggle() end, desc = "Toggle LazyGit terminal", mode = 't'},
    }
}
