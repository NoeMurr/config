    --------------------------------------------
-- Vim options
--------------------------------------------

-- Status bar only in last window: in other is just a
-- divider
vim.opt.laststatus = 3
vim.api.nvim_set_hl(0 , 'Statusline', {link = 'Normal'})
vim.opt.statusline = "%{expand('%:p')} %= %l,%c %p%%"

vim.opt.mouse = 'a' -- mouse in all modes

vim.cmd.colorscheme "catppuccin"
vim.opt.listchars = {lead = '·', trail = '·', tab = '|·>' }
vim.opt.list = true -- show trailing and end character
vim.opt.number = true -- show line number
vim.opt.relativenumber = true -- show line number as relative 
vim.opt.expandtab = true -- convert tab to spaces
vim.opt.tabstop = 4 -- tab = 4 spaces
vim.opt.shiftwidth = 0 -- forced to be the same as tabstop 
vim.opt.autochdir = true -- working directory following the current buffer
vim.opt.splitright = true -- open new split on right instead of left
vim.opt.spell = true -- spell checking
vim.opt.spelllang=en_us -- english

vim.opt.hlsearch = false -- : set nohlsearch

vim.opt.clipboard = 'unnamedplus' -- drop the difference between "+ and "* allowing the copy to go diretly to the clipboard

-- Global plugin options
vim.g.blamer_enabled = 1
vim.g.blamer_show_in_visual_mode = 0

vim.g.telescope_insert_path_source_dir = 'source'

