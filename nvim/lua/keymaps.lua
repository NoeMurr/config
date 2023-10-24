local telescope = require('telescope')
local telescope_builtin = require('telescope.builtin')
local dap = require('dap')

nmap('<F1>', ':WhichKey<CR>') -- help keybindings

nmap('{', 'o<ESC>')
nmap('}', 'O<ESC>')

vmap('<C-k>', ':pyf /usr/share/clang/clang-format.py<cr>') -- format selected lines in visual mode
nmap('<C-k>', ':pyf /usr/share/clang/clang-format.py<cr>') -- format current line in normal mode

nmap('<leader>fpt', function() telescope.extensions.file_browser.file_browser( { cwd = get_project_root_or_cwd() } ) end, {desc = 'Open file browser in project root'})
nmap('<leader>ff', function() telescope_builtin.find_files( { cwd = get_project_root_or_cwd() } ) end, {desc = 'Open file in project'})
nmap('<leader>fg', function() telescope_builtin.live_grep( { cwd = get_project_root_or_cwd() } ) end, {desc = 'Grep in project'})
nmap('<leader>fo', function() telescope_builtin.oldfiles( { cwd = get_project_root_or_cwd() } ) end, {desc = 'Open recent file'}) 
nmap('<leader>t', function() telescope_builtin.builtin({ include_extensions = true }) end, {desc = 'Open telescope pickers list'}) 
nmap('<leader>o', telescope_builtin.lsp_document_symbols, {desc = 'Goto symbol in document'})

nmap('<leader>ft', ':Telescope file_browser<CR>', {desc = 'Open file browser in current directory'})
nmap('<leader>fb', ':Telescope buffers<CR>', {desc = 'Open buffers list'})
nmap('<leader>/', ':Telescope current_buffer_fuzzy_find<CR>', {desc = 'Search in file'})
nmap('<leader>ca', vim.lsp.buf.code_action, {desc = 'Code actions pop up'}) -- code actionf rom lsp (fix-available)
nmap('<leader>qf', ':Telescope quickfix<CR>', {desc = 'Open quickfix telescope picker'})
nmap('<leader>qh', ':Telescope quickfixhistory<CR>', {desc = 'Open quickfix history telescope picker'})

-- dap bindings
nmap('<F4>', ':DapTerminate<CR>', {desc = 'DAP: Terminate active debug session'})
nmap('<F5>', ':Telescope dap configurations<CR>', {desc = 'DAP: open dap configurations'})
nmap('<F6>', ':DapToggleBreakpoint<CR>', {desc = 'DAP: toggle breakpoint'}) 
nmap('<F30>', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, {desc = 'DAP: toggle breakpoint with condition'})
nmap('<F33>', require('dap').run_to_cursor, {desc = 'DAP: run to cursor'})
nmap('<F8>', require("dapui").toggle, {desc = 'DAP: toggle dap ui mode'}) 
nmap('<F9>', ':DapContinue<CR>', {desc = 'DAP: continue'}) 
nmap('<F10>', ':DapStepOver<CR>', {desc = 'DAP: step over'}) 
nmap('<F11>', ':DapStepInto<CR>', {desc = 'DAP: step into'}) 
nmap('<F12>', ':DapStepOut<CR>', {desc = 'DAP: step out'}) 

nmap('<Leader>df', ':Telescope dap frames<CR>', {desc = 'DAP: open current thread\'s stack frames'})
nmap('<Leader>db', ':Telescope dap list_breakpoints<CR>', {desc = 'DAP: list active breakpoints'})
nmap('<Leader>dr', function() require('dap').repl.toggle({height = 10}, 'split') end , {desc = 'DAP: open compile console'})

nmap('<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  local view    = widgets.centered_float(widgets.scopes)

  vim.keymap.set('n', '<ESC>', view.close, { buffer = view.buf })
end, {desc = 'DAP: show current stack'})

nmap('<Leader>dp', function()
  local widgets = require('dap.ui.widgets')
  local view    = widgets.hover()

  vim.keymap.set('n', '<ESC>', view.close, { buffer = view.buf })
end, {desc = 'DAP: show variable under the cursor'})

nmap('<Leader>de', function()
  local widgets = require('dap.ui.widgets')
  local view    = widgets.centered_float(widgets.expression)
  view.close()
  view.open( vim.fn.input('expression: ') )

  vim.keymap.set('n', '<ESC>', view.close, { buffer = view.buf })
end, {desc = 'DAP: evaluate expression'})

-- mapping for moving lines 
-- normal
nmap('J', ':m +1<CR>', {desc = 'move current line up one line'}) -- move up one line
nmap('K', ':m -2<CR>', {desc = 'move current line down one line'}) -- move down one line

-- visual
-- vmap('J', ':m +1 <CR> gv') -- move up one line
-- vmap('K', ':m -2 <CR> gv') -- move down one line the gv commands is used for resetting the visual selection

-- diagnostic float
nmap('<leader>sd', vim.diagnostic.open_float, {desc = 'open diagnostics popup'})

-- buffer navigation
nmap('<A-l>', ':BufferNext<CR>', {desc = 'go to next buffer'})
nmap('<A-h>', ':BufferPrevious<CR>', {desc = 'go to previous buffer'})

nmap('<leader>w', ':bd<CR>', {desc = 'close current buffer'})

nmap('<leader>h', '<C-W>h', {desc = 'move to left window'})
nmap('<leader>j', '<C-W>j', {desc = 'move to window down'})
nmap('<leader>k', '<C-W>k', {desc = 'move to window up'})
nmap('<leader>l', '<C-W>l', {desc = 'move to right window'})

nmap('<leader>p', '"0p', {desc = 'paste last yanked value, not cut'})

-- disabling mappings
map('q:', '<nop>');
nmap("<Space>", '<nop>');
