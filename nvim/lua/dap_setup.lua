require("utils")
-- dap setup
local dap = require('dap')
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '/home/noemurr/.vscode/extensions/ms-vscode.cpptools-1.14.3-linux-x64/debugAdapters/bin/OpenDebugAD7',
}

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
    launch_tmpl = launch_tmpl or cppdbgTempl
    if dap.configurations.dap ~= nil then
        dap.configurations.cpp = { 
            make_launch_config_helper(launch_tmpl)
        }
    else
        table.insert(dap.configurations.cpp, make_launch_config_helper(launch_tmpl))
    end
end

vim.api.nvim_create_user_command('AddDapConfig', ':lua add_dap_config()<CR>', {nargs=0})

dap.configurations.cpp = {};

-- local conf = {
--     {
--         name = "Launch CPP with arguments",
--         type = "cppdbg",
--         request = "launch",
--         program = function()
--             return vim.fn.input('Path to executable: ', get_project_root_or_cwd() .. '/', 'file')
--         end,
--         args = function() 
--             local arg_string = vim.fn.input('arguments [empty for none]: ')
--             return vim.fn.split(arg_string, " ", true)
--         end,
--         cwd = "",
--         stopAtEntry = true,
--         setupCommands = {
--             { 
--                 text = '-enable-pretty-printing',
--                 description =  'enable pretty printing',
--                 ignoreFailures = false 
--             },
--         },
--     },
--     {
--         name = "Launch CPP",
--         type = "cppdbg",
--         request = "launch",
--         program = function()
--             return vim.fn.input('Path to executable: ', get_project_root_or_cwd() .. '/', 'file')
--         end,
--         cwd = function() return get_project_root_or_cwd() end,
--         stopAtEntry = true,
--         setupCommands = {
--             { 
--                 text = '-enable-pretty-printing',
--                 description =  'enable pretty printing',
--                 ignoreFailures = false 
--             },
--         },
--     },
-- }
--
-- dap.configurations.cpp = conf;

require('dapui').setup()