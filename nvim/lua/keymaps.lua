nmap('{', 'o<ESC>')
nmap('}', 'O<ESC>')

vmap('<C-k>', ':pyf /usr/share/clang/clang-format.py<cr>') -- format selected lines in visual mode
nmap('<C-k>', ':pyf /usr/share/clang/clang-format.py<cr>') -- format current line in normal mode

nmap('<C-p>t', ':lua require("telescope").extensions.file_browser.file_browser( { cwd = "' .. get_project_root_or_cwd() .. '" } )<CR>')
nmap('<F2>', ':lua require("telescope.builtin").live_grep( { cwd = "' .. get_project_root_or_cwd() .. '" } )<CR>')
nmap('<F3>', ':lua require("telescope.builtin").find_files( { cwd = "' .. get_project_root_or_cwd() .. '" } )<CR>')

nmap('t', ':Telescope file_browser<CR>')
nmap('B', ':Telescope buffers<CR>')
nmap('<C-f>', ':Telescope current_buffer_fuzzy_find<CR>')
nmap('ca', ':lua vim.lsp.buf.code_action()<CR>') -- code actionf rom lsp (fix-available)

-- dap bindings
nmap('<F5>', ':Telescope dap configurations<CR>')
nmap('<F6>', ':DapToggleBreakpoint<CR>') 
nmap('<F7>', ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
nmap('<F8>', ':lua require("dapui").toggle()<CR>') 
nmap('<F9>', ':DapContinue<CR>') 
nmap('<F10>', ':DapStepOver<CR>') 
nmap('<F11>', ':DapStepInto<CR>') 
nmap('<F12>', ':DapStepOut<CR>') 
nmap('<F4>', ':DapTerminate<CR>')

-- mapping for moving lines 
-- normal
nmap('J', ':m +1<CR>') -- move up one line
nmap('K', ':m -2<CR>') -- move down one line

-- visual
-- vmap('J', ':m +1 <CR> gv') -- move up one line
-- vmap('K', ':m -2 <CR> gv') -- move down one line the gv commands is used for resetting the visual selection

-- diagnostic float
nmap('<A-d>', ':lua vim.diagnostic.open_float()<CR>')

-- buffer navigation
nmap('<A-l>', ':BufferNext<CR>')
nmap('<A-h>', ':BufferPrevious<CR>')

nmap('W', ':lua EnterResizeMode()<CR>')
