vim.api.nvim_create_user_command('FilterFile', function() 
    -- vim.cmd('echo "setlocal foldexpr=getline(v:lnum)=~\'' .. vim.fn.input('Search pattern: ') .. '\'?0:1 foldmethod=expr"')
    -- vim.cmd('echo "' .. vim.fn.input('Search pattern: ') .. '"')
    local val = vim.fn.input('search pattern: ')
    vim.cmd('redraw')
    vim.cmd('setlocal foldexpr=getline(v:lnum)=~\'' .. val .. '\'?0:1 foldmethod=expr')
end, {nargs=0})
