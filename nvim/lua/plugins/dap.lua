return {
    {
        "Joakker/lua-json5",
        build = "./install.sh",
        lazy = false,
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "Joakker/lua-json5",
        },
        config = function()
            require('dap.ext.vscode').json_decode = require('json5').parse
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
            handlers = {},
            automatic_installation = true,
        },
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim",
        }
    }, -- setup mason adapters
}
