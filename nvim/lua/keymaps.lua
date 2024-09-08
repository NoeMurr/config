nmap('{', 'o<ESC>')
nmap('}', 'O<ESC>')

vmap('<C-k>', vim.lsp.buf.format, {desc = 'forat selected line in visual mode'})
nmap('<C-k>', function() 
    local r, c = unpack(vim.api.nvim_win_get_cursor(0))
    vim.lsp.buf.format({range = {['start'] = {r, 0}, ['end'] = {r, 0}}}) 
end, {desc = 'format current line'})
nmap('<C-A-K>', vim.lsp.buf.format, {desc = 'format all file'})


nmap('<leader>ca', vim.lsp.buf.code_action, {desc = 'Code actions pop up'}) -- code actionf rom lsp (fix-available)

-- mapping for moving lines 
-- normal
nmap('<A-j>', function() vim.cmd('m +1') end, {desc = 'move current line up one line'}) -- move up one line
nmap('<A-k>', function() vim.cmd('m -2') end, {desc = 'move current line down one line'}) -- move down one line

-- visual
-- vmap('J', ':m +1 <CR> gv') -- move up one line
-- vmap('K', ':m -2 <CR> gv') -- move down one line the gv commands is used for resetting the visual selection

-- diagnostic float
nmap('<leader>sd', vim.diagnostic.open_float, {desc = 'open diagnostics popup'})
nmap('<leader>s[', vim.diagnostic.goto_prev, {desc = 'goto previous diagnostic'})
nmap('<leader>s]', vim.diagnostic.goto_next, {desc = 'goto next diagnostic'})

-- buffer navigation
nmap('<A-l>', function() vim.cmd('BufferNext') end, {desc = 'go to next buffer'})
nmap('<A-h>', function() vim.cmd('BufferPrevious') end, {desc = 'go to previous buffer'})

nmap('<leader>w', function() vim.cmd('bd') end, {desc = 'close current buffer'})

nmap('<leader>h', '<C-W>h', {desc = 'move to left window'})
nmap('<leader>j', '<C-W>j', {desc = 'move to window down'})
nmap('<leader>k', '<C-W>k', {desc = 'move to window up'})
nmap('<leader>l', '<C-W>l', {desc = 'move to right window'})

nmap('<leader>p', '"0p', {desc = 'paste last yanked value, not cut'})

nmap('<leader>z', function() 
    vim.cmd('setlocal foldexpr=getline(v:lnum)=~@/?0:1 foldmethod=expr')
    vim.cmd('normal zM')
end, {desc = 'Fold all the lines not matching the last search'})

nmap('<leader>Z', function() 
    vim.cmd('setlocal foldexpr=getline(v:lnum)=~@/?1:0 foldmethod=expr')
    vim.cmd('normal zM')
end, {desc = 'Fold all the lines not matching the last search'})

-- disabling mappings
nmap('q:', '<nop>');
vmap('q:', '<nop>');
imap('q:', '<nop>');

nmap("<Space>", '<nop>');
