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
    extensions = {
        file_browser = {
            mappings = {
                n = {
                    ['C'] = function() 
                        local cls = vim.fn.input('Insert the class Name: ')
                        if cls ~= "" then
                            local header = cls .. '.h'
                            local source = cls .. '.cpp'
                            if os.rename(header, header) and os.rename(source, source) then
                                print("Error files already exists")
                                return;
                            end
                            -- creating files
                            local hf = io.open(header, 'w')
                            local sf = io.open(source, 'w')
                          
                            if not hf or not sf then 
                                print("Error cannot create header or source file")
                            end
        
                            io.close(hf)
                            io.close(sf)
                        end
                    end
                }
            }
        }
    }

})

require("telescope").load_extension('fzf')
require("telescope").load_extension('file_browser')
require('telescope').load_extension('dap')
