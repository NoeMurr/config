local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local dap = require('dap')

vim.g.mapleader = " "

nmap('{', 'o<ESC>')
nmap('}', 'O<ESC>')

vmap('<C-k>', ':pyf /usr/share/clang/clang-format.py<cr>') -- format selected lines in visual mode
nmap('<C-k>', ':pyf /usr/share/clang/clang-format.py<cr>') -- format current line in normal mode

nmap('<leader>fpt', function() telescope.extensions.file_browser.file_browser( { cwd = get_project_root_or_cwd() } ) end)
nmap('<leader>fg', function() telescope_builtin.live_grep( { cwd = get_project_root_or_cwd() } ) end)
nmap('<leader>ff', function() telescope_builtin.find_files( { cwd = get_project_root_or_cwd() } ) end)
nmap('<leader>fo', function() telescope_builtin.oldfiles( { cwd = get_project_root_or_cwd() } ) end) 
nmap('<leader>t', function() telescope_builtin.builtin({ include_extensions = true }) end) 
nmap('<leader>o', telescope_builtin.lsp_document_symbols)

nmap('<leader>ft', ':Telescope file_browser<CR>')
nmap('<leader>fb', ':Telescope buffers<CR>')
nmap('<leader>/', ':Telescope current_buffer_fuzzy_find<CR>')
nmap('<leader>ca', vim.lsp.buf.code_action) -- code actionf rom lsp (fix-available)
nmap('<leader>qf', ':Telescope quickfix<CR>')
nmap('<leader>qh', ':Telescope quickfixhistory<CR>')

-- dap bindings
nmap('<F4>', ':DapTerminate<CR>')
nmap('<F5>', ':Telescope dap configurations<CR>')
nmap('<F6>', ':DapToggleBreakpoint<CR>') 
nmap('<F30>', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
nmap('<F33>', require('dap').run_to_cursor)
nmap('<F8>', require("dapui").toggle) 
nmap('<F9>', ':DapContinue<CR>') 
nmap('<F10>', ':DapStepOver<CR>') 
nmap('<F11>', ':DapStepInto<CR>') 
nmap('<F12>', ':DapStepOut<CR>') 

nmap('<Leader>df', ':Telescope dap frames<CR>')
nmap('<Leader>db', ':Telescope dap list_breakpoints<CR>')
nmap('<Leader>dr', function() require('dap').repl.toggle({height = 10}, 'abo split') end )

nmap('<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  local view    = widgets.centered_float(widgets.scopes)

  vim.keymap.set('n', '<ESC>', view.close, { buffer = view.buf })
end)

nmap('<Leader>dp', function()
  local widgets = require('dap.ui.widgets')
  local view    = widgets.hover()

  vim.keymap.set('n', '<ESC>', view.close, { buffer = view.buf })
end)

nmap('<Leader>de', function()
  local widgets = require('dap.ui.widgets')
  local view    = widgets.centered_float(widgets.expression)
  view.close()
  view.open( vim.fn.input('expression: ') )

  vim.keymap.set('n', '<ESC>', view.close, { buffer = view.buf })
end)

-- mapping for moving lines 
-- normal
nmap('J', ':m +1<CR>') -- move up one line
nmap('K', ':m -2<CR>') -- move down one line

-- visual
-- vmap('J', ':m +1 <CR> gv') -- move up one line
-- vmap('K', ':m -2 <CR> gv') -- move down one line the gv commands is used for resetting the visual selection

-- diagnostic float
nmap('<leader>d', vim.diagnostic.open_float)

-- buffer navigation
nmap('<A-l>', ':BufferNext<CR>')
nmap('<A-h>', ':BufferPrevious<CR>')

nmap('<leader>r', ':lua EnterResizeMode()<CR>')

nmap('<leader>w', ':bd<CR>')

nmap('<leader>h', '<C-W>h')
nmap('<leader>j', '<C-W>j')
nmap('<leader>k', '<C-W>k')
nmap('<leader>l', '<C-W>l')

nmap('<leader>p', '"0p')

-- disabling mappings
map('q:', '<nop>');
nmap("<Space>", '<nop>');
