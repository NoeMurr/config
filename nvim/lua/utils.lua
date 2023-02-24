local function internal_map(mode, lhs, rhs, opts)
	local options = {noremap=true, silent=true}
	if opts then 
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function map(lhs, rhs, opts) 
	internal_map('', lhs, rhs, opts)
end

function nmap(lhs, rhs, opts)
	internal_map('n', lhs, rhs, opts)
end

function imap(lhs, rhs, opts)
	internal_map('i', lhs, rhs, opts)
end

function vmap(lhs, rhs, opts)
	internal_map('v', lhs, rhs, opts)
end

function trim(s)
   return s:match( "^%s*(.-)%s*$" )
end

function get_project_root_or_cwd()
    local handler = io.popen('git rev-parse --show-toplevel')

    if not handler then return vim.fn.getcwd() end

    local output = handler:read('*a')
    local ret = handler:close()

    if ret then return trim(output) else return vim.fn.getcwd() end
end
