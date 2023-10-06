-- telescope & extensions
local send_all_to_quickfix = function(prompt_bufnr)
    require('telescope.actions').send_to_qflist(prompt_bufnr)
    require('telescope.builtin').quickfix()
end

local send_selected_to_quickfix = function(prompt_bufnr)
    require('telescope.actions').send_selected_to_qflist(prompt_bufnr)
    require('telescope.builtin').quickfix()
end

local path_actions = require('telescope_insert_path').setup({source_dir = "source"})

require("telescope").setup({
    defaults = {
        path_display = {
            "smart"
        },
        initial_mode = 'normal',
        mappings = {
            i = {
                ["<C-q>"] = send_all_to_quickfix,
                ["<M-q>"] = send_selected_to_quickfix,
                ["<C-p>g"] = path_actions.insert_relgit_a_insert,
                ["<C-p>s"] = path_actions.insert_relsource_a_insert
            },
            n = {
                ["<C-q>"] = send_all_to_quickfix,
                ["<M-q>"] = send_selected_to_quickfix,
                ["<C-p>g"] = path_actions.insert_relgit_a_normal,
                ["<C-p>s"] = path_actions.insert_relsource_a_normal
            }
        }
    },
    pickers = {
        buffers = {
            mappings = {
                n = {
                    ['d'] = require('telescope.actions').delete_buffer
                }
            }
        },
        quickfix = {
            mappings = {
                i = {
                    ["<C-q>"] = false,
                    ["<M-q>"] = false
                },
                n = {
                    ["<C-q>"] = false,
                    ["<M-q>"] = false
                }
            }
        },
        quickfixhistory = {
            mappings = {
                i = {
                    ["<C-q>"] = false,
                    ["<M-q>"] = false
                },
                n = {
                    ["<C-q>"] = false,
                    ["<M-q>"] = false
                }
            }
        },
        find_files = {
            initial_mode = 'insert',
        },
        live_grep = {
            initial_mode = 'insert'
        },
        current_buffer_fuzzy_find = {
            initial_mode = 'insert'
        },
        builtin = {
            initial_mode = 'insert'
        }
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_cursor {
              -- even more opts
            }
        },
        file_browser = {
            hijack_netrw = true,
            mappings = {
                n = {
                    ['C'] = function(prompt_bufnr)
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

                        local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                        picker:refresh()
                    end
                }
            }
        }
    }

})

require("telescope").load_extension('fzf')
require("telescope").load_extension('file_browser')
require('telescope').load_extension('dap')
require('telescope').load_extension('ui-select')
