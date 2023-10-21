package.path = package.path .. ";../?.lua"

require("utils")
require("deepcopy")

-- Cppdbg dap launch configuration template
local cppdbgTempl =
  {
    type = "cppdbg",
    request = "launch",
    stopAtEntry = false,
    -- auto_continue_if_many_stopped = false,
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
    -- if not dap then
    --     vim.
    -- end
    launch_tmpl = launch_tmpl or cppdbgTempl
    if dap.configurations.dap ~= nil then
        dap.configurations.cpp = { 
            make_launch_config_helper(table.deepcopy(launch_tmpl))
        }
    else
        table.insert(dap.configurations.cpp, make_launch_config_helper(table.deepcopy(launch_tmpl)))
    end
end


return {
    { 
        'mfussenegger/nvim-dap',
        config = function() 
            local dap = require('dap')

            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = '/home/noemurr/.vscode/extensions/ms-vscode.cpptools-1.14.3-linux-x64/debugAdapters/bin/OpenDebugAD7',
            }

            vim.api.nvim_create_user_command('AddDapConfig', ':lua add_dap_config()<CR>', {nargs=0})
        end
    },

    { 'rcarriga/nvim-dap-ui' }, -- debug ui
}

-- Plug( 'mfussenegger/nvim-dap' ) -- Debugger Adapter Protocol
-- Plug( 'rcarriga/nvim-dap-ui' ) -- Debugger Adapter Protocol Ui
-- Plug( 'theHamsta/nvim-dap-virtual-text' ) -- debugger virtual text
