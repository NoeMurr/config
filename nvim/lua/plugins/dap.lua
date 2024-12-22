--- Extends dap.configurations with entries read from .vscode/launch.json
local function load_launchjs(path, type_to_filetypes)
    local vscode = require('dap.ext.vscode')
    local dap = require('dap')

    type_to_filetypes = vim.tbl_extend('keep', type_to_filetypes or {}, vscode.type_to_filetypes)
    local configurations = vscode.getconfigs(path)

    assert(configurations, "launch.json must have a 'configurations' key")
    for _, config in ipairs(configurations) do
        assert(config.type, "Configuration in launch.json must have a 'type' key")
        assert(config.name, "Configuration in launch.json must have a 'name' key")
        -- avoid duplicates, the original was doing this for:
        -- local filetypes = type_to_filetypes[config.type] or { config.type, }
        -- for _, filetype in pairs(filetypes) do
        local filetype = config.type
        local dap_configurations = dap.configurations[filetype] or {}
        for i, dap_config in pairs(dap_configurations) do
            if dap_config.name == config.name then
                -- remove old value
                table.remove(dap_configurations, i)
            end
        end
        table.insert(dap_configurations, config)
        dap.configurations[filetype] = dap_configurations
        -- end
    end
end

return {
    {
        "Joakker/lua-json5",
        build = "./install.sh",
        lazy = false,
    },
    {
        'mfussenegger/nvim-dap',
        dir = "/home/noe/workspace/nvim-dap",
        dependencies = {
            "Joakker/lua-json5",
        },
        config = function()
            require('dap').var_placeholders["${workspaceFolder}"] = get_project_root_or_cwd;
            require('dap.ext.vscode').json_decode = require('json5').parse

            vim.api.nvim_create_user_command("LoadProjectLaunchJson", function()
                load_launchjs(get_project_root_or_cwd() .. '/.launch.json5');
            end, { desc = "loads the .launch.json5 file in tuhe project root" })
        end,
        keys = {
            { '<F4>',       function() vim.cmd('DapTerminate') end,                                               desc = 'DAP: Terminate active debug session' },

            { '<F5>',       function() vim.cmd('Telescope dap configurations') end,                               desc = 'DAP: open dap configurations' },

            { '<F6>',       function() vim.cmd('DapToggleBreakpoint') end,                                        desc = 'DAP: toggle breakpoint' },

            { '<F30>',      function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'DAP: toggle breakpoint with condition' },

            { '<F33>',      function() require('dap').run_to_cursor() end,                                        desc = 'DAP: run to cursor' },

            { '<F9>',       function() vim.cmd('DapContinue') end,                                                desc = 'DAP: continue' },

            { '<F10>',      function() vim.cmd('DapStepOver') end,                                                desc = 'DAP: step over' },

            { '<F11>',      function() vim.cmd('DapStepInto') end,                                                desc = 'DAP: step into' },

            { '<F12>',      function() vim.cmd('DapStepOut') end,                                                 desc = 'DAP: step out' },

            { '<Leader>df', function() vim.cmd('Telescope dap frames') end,                                       desc = 'DAP: open current thread\'s stack frames' },

            { '<Leader>db', function() vim.cmd('Telescope dap list_breakpoints') end,                             desc = 'DAP: list active breakpoints' },

            { '<Leader>dr', function() require('dap').repl.toggle({ height = 10 }, 'split') end,                  desc = 'DAP: open compile console' },

            {
                '<Leader>ds',
                function()
                    local widgets = require('dap.ui.widgets')
                    local view    = widgets.centered_float(widgets.scopes)

                    vim.keymap.set('n', '<ESC>', view.close, { buffer = view.buf })
                end,
                desc = 'DAP: show current stack'
            },

            {
                '<Leader>dp',
                function()
                    local widgets = require('dap.ui.widgets')
                    local view    = widgets.hover()

                    vim.keymap.set('n', '<ESC>', view.close, { buffer = view.buf })
                end,
                desc = 'DAP: show variable under the cursor'
            },

            {
                '<Leader>de',
                function()
                    local widgets = require('dap.ui.widgets')
                    local view    = widgets.centered_float(widgets.expression)
                    view.close()
                    view.open(vim.fn.input('expression: '))

                    vim.keymap.set('n', '<ESC>', view.close, { buffer = view.buf })
                end,
                desc = 'DAP: evaluate expression'
            }
        }
    },
    {
        'rcarriga/nvim-dap-ui',
        keys = {
            { '<F8>', function() require("dapui").toggle() end, desc = 'DAP: toggle dap ui mode' },
        },
        opts = {}
    }, -- debug ui
    {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
            handlers = {
                function(config)
                    local dap = require('dap')
                    local Optional = require('mason-core.optional')

                    Optional.of_nilable(config.adapters):map(function(adapter_config)
                        dap.adapters[config.name] = adapter_config
                        local configuration = config.configurations or {}
                        if not vim.tbl_isempty(configuration) then
                            -- this workaround is to avoid different duplication of the configurations for each file type.
                            dap.configurations[config.name] = vim.list_extend(dap.configurations[config.name] or {},
                                configuration)

                            -- the default function does something like that:
                            -- for _, filetype in ipairs(config.filetypes) do
                            --     dap.configurations[filetype] = vim.list_extend(dap.configurations[filetype] or {},
                            --         configuration)
                            -- end
                        end
                    end)
                end
            },
            automatic_installation = true,
        },
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim",
        }
    }, -- setup mason adapters
}
