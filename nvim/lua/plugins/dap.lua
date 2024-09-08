package.path = package.path .. ";../?.lua"

require("utils")
require("deepcopy")

-- Cppdbg dap launch configuration template
local cppdbgTempl =
  {
    type = "cppdbg",
    request = "launch",
    stopAtEntry = false,
    setupCommands = {
        {
             text = '-enable-pretty-printing',
             description =  'enable pretty printing',
             ignoreFailures = false,
        },
    },
}

-- Cppdbg dap launch configuration template
local cppdbgAttachTempl =
  {
    type = "cppdbg",
    request = "attach",
    stopAtEntry = false,
    setupCommands = {
        {
             text = '-enable-pretty-printing',
             description =  'enable pretty printing',
             ignoreFailures = false,
        },
    },
}

local function make_launch_config_helper( launch_template )
    local program_name = vim.fn.input('Path to executable: ', get_project_root_or_cwd() .. '/', 'file')
    local def_cwd_name =  string.match(program_name, '(.*)/.*$')
    local cwd_name = vim.fn.input('Path to cwd: ', def_cwd_name, 'file')
    local argstring = vim.fn.input('Executable arguments: ')
    local launch_name = vim.fn.input('Launch name: ', "Launch cppdbg")

    launch_template['name'] = launch_name
    launch_template['program'] = program_name
    launch_template['cwd'] = cwd_name
    launch_template['args'] = vim.split(argstring, " ")

    return launch_template
end

function add_dap_config(launch_tmpl)
    local dap = require('dap')
    launch_tmpl = launch_tmpl or cppdbgTempl
    
    dap.configurations.cpp = dap.configurations.cpp or {}
    
    table.insert(dap.configurations.cpp, make_launch_config_helper(table.deepcopy(launch_tmpl)))
end

function remove_dap_config(name)
    local dap = require('dap')
    
    for i, conf in ipairs(dap.configurations.cpp) do
        if conf.name == name then
            table.remove(dap.configurations.cpp, i)
            return;
        end
    end

    error("Unknown configuration " .. name)
end

return {
    { 
        'mfussenegger/nvim-dap',
        dir = '/home/noemurr/personal-dev/nvim-dap',
        config = function() 
            local dap = require('dap')

            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = '/home/noemurr/.vscode/extensions/ms-vscode.cpptools-1.19.9-linux-x64/debugAdapters/bin/OpenDebugAD7',
            }

            vim.api.nvim_create_user_command('AddDapConfig', ':lua add_dap_config()<CR>', {nargs=0})
            vim.api.nvim_create_user_command('RemoveDapConfig', ':lua remove_dap_config(vim.fn.input(\'Dap configuration: \'))<CR>', {nargs=0})
        end,
        keys = {
            {'<F4>', function() vim.cmd('DapTerminate') end, desc = 'DAP: Terminate active debug session'},

            -- {'<F5>', ':Telescope dap configurations<CR>', desc = 'DAP: open dap configurations'},
            {'<F5>', function() vim.cmd('Telescope dap configurations') end, desc = 'DAP: open dap configurations'},

            {'<F6>', function() vim.cmd('DapToggleBreakpoint') end, desc = 'DAP: toggle breakpoint'}, 

            {'<F30>', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'DAP: toggle breakpoint with condition'},

            {'<F33>', function() require('dap').run_to_cursor() end, desc = 'DAP: run to cursor'},
            --

            {'<F9>', function() vim.cmd('DapContinue') end, desc = 'DAP: continue'}, 

            {'<F10>', function() vim.cmd('DapStepOver') end, desc = 'DAP: step over'}, 

            {'<F11>', function() vim.cmd('DapStepInto') end, desc = 'DAP: step into'}, 

            {'<F12>', function() vim.cmd('DapStepOut') end, desc = 'DAP: step out'}, 

            {'<Leader>df', function() vim.cmd('Telescope dap frames') end, desc = 'DAP: open current thread\'s stack frames'},

            {'<Leader>db', function() vim.cmd('Telescope dap list_breakpoints') end, desc = 'DAP: list active breakpoints'},
            
            {'<Leader>dr', function() require('dap').repl.toggle({height = 10}, 'split') end , desc = 'DAP: open compile console'},

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
                    view.open( vim.fn.input('expression: ') )

                    vim.keymap.set('n', '<ESC>', view.close, { buffer = view.buf })
                end, desc = 'DAP: evaluate expression'
            }
        }
    },

    { 
        'rcarriga/nvim-dap-ui',
        keys = {
            {'<F8>', function() require("dapui").toggle() end, desc = 'DAP: toggle dap ui mode'},
        },
        opts = {}
    }, -- debug ui
}

-- Plug( 'mfussenegger/nvim-dap' ) -- Debugger Adapter Protocol
-- Plug( 'rcarriga/nvim-dap-ui' ) -- Debugger Adapter Protocol Ui
-- Plug( 'theHamsta/nvim-dap-virtual-text' ) -- debugger virtual text
