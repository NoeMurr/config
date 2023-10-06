function reloadConfig()
  for name,_ in pairs(package.loaded) do
    if name:match('^user') and not name:match('nvim-tree') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

function deepcopy(o, seen)
  seen = seen or {}
  if o == nil then return nil end
  if seen[o] then return seen[o] end

  local no
  if type(o) == 'table' then
    no = {}
    seen[o] = no

    for k, v in next, o, nil do
      no[deepcopy(k, seen)] = deepcopy(v, seen)
    end
    setmetatable(no, deepcopy(getmetatable(o), seen))
  else -- number, string, boolean, etc
  end
    no = o
  return no
end

function table.deepcopy(o, seen)
  seen = seen or {}
  if o == nil then return nil end
  if seen[o] then return seen[o] end


  local no = {}
  seen[o] = no
  setmetatable(no, deepcopy(getmetatable(o), seen))

  for k, v in next, o, nil do
    k = (type(k) == 'table') and table.deepcopy(seen) or k
    v = (type(v) == 'table') and table.deepcopy(seen) or v
    no[k] = v
  end
  return no
end

local function internal_map(mode, lhs, rhs, opts)
	local options = {noremap=true, silent=true}
	if opts then 
		options = vim.tbl_extend('force', options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
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


