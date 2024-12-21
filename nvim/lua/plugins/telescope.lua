local send_all_to_quickfix = function(prompt_bufnr)
    require('telescope.actions').send_to_qflist(prompt_bufnr)
    require('telescope.builtin').quickfix()
end

local send_selected_to_quickfix = function(prompt_bufnr)
    require('telescope.actions').send_selected_to_qflist(prompt_bufnr)
    require('telescope.builtin').quickfix()
end

return {
    { -- telescope base
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',

        dependencies = { 'nvim-lua/plenary.nvim' },

        keys = {
            {
                '<leader>fpt',
                function()
                    require('telescope').extensions.file_browser.file_browser({
                        cwd =
                            get_project_root_or_cwd()
                    })
                end,
                desc = 'Open file browser in project root'
            },
            { '<leader>ff', function() require('telescope.builtin').find_files({ cwd = get_project_root_or_cwd() }) end, desc = 'Open file in project' },
            { '<leader>fg', function() require('telescope.builtin').live_grep({ cwd = get_project_root_or_cwd() }) end,  desc = 'Grep in project' },
            { '<leader>fo', function() require('telescope.builtin').oldfiles({ cwd = get_project_root_or_cwd() }) end,   desc = 'Open recent file' },
            { '<leader>t',  function() require('telescope.builtin').builtin({ include_extensions = true }) end,          desc = 'Open telescope pickers list' },
            { '<leader>o',  require('telescope.builtin').lsp_document_symbols,                                           desc = 'Goto symbol in document' },

            { '<leader>ft', function() require('telescope').extensions.file_browser.file_browser() end,                  desc = 'Open file browser in current directory' },
            { '<leader>fb', function() require('telescope.builtin').buffers() end,                                       desc = 'Open buffers list' },
            { '<leader>/',  function() require('telescope.builtin').current_buffer_fuzzy_find() end,                     desc = 'Search in file' },
            { '<leader>qf', function() require('telescope.builtin').quickfix() end,                                      desc = 'Open quickfix telescope picker' },
            { '<leader>qh', function() require('telescope.builtin').quickfixhistory() end,                               desc = 'Open quickfix history telescope picker' },
        },

        config = function()
            require('telescope').setup({
                defaults = {
                    path_display = {
                        "smart"
                    },
                    initial_mode = 'normal',
                    mappings = {
                        i = {
                            ["<C-q>"] = send_all_to_quickfix,
                            ["<M-q>"] = send_selected_to_quickfix
                        },
                        n = {
                            ["<C-q>"] = send_all_to_quickfix,
                            ["<M-q>"] = send_selected_to_quickfix
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
                    },
                }
            })
        end
    }, -- end of telescope base plugin configuration

    -- extensions
    -- {
    --     'nvim-telescope/telescope-fzf-native.nvim',
    --     build =
    --     'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    --     config = function()
    --         require("telescope").load_extension('fzf')
    --     end
    -- },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").load_extension('file_browser')
        end
    },

    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").load_extension('ui-select')
        end
    },

    {
        'nvim-telescope/telescope-dap.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-dap', 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require("telescope").load_extension('dap')
        end
    },
}
