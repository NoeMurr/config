-------------------------------------------
-- Requirements
-- -----------------------------------------
require('utils')
require('plugins') -- plugins installations 

--------------------------------------------
-- Plugin's setups
-- -----------------------------------------
require('keymaps')
require('vim_options')
require('startify_setup') -- start screen
require('lspconfig_setup')
require('cmp_setup') -- autocomplete plugin
require('dap_setup') -- debugger adapter
require('telescope_setup')
-- require('nvim_comment_setup') -- allow me to autocomment
require('barbar_setup') -- buffer bar
require('themes_setup') -- themes
require('tree_sitter') --treesitter
require('oil_setup') -- oil
require('which_key') -- 


require('scratch_setup')

--------------------------------------------
-- EOF
--------------------------------------------
