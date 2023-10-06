-- lsp configurations
local lspconfig = require("lspconfig")

-- clangd server setup
lspconfig.clangd.setup({
 cmd = {
    -- see clangd --help-hidden
    "clangd",
    "--background-index",
    -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
    -- to add more checks, create .clang-tidy file in the root directory
    -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
    "--clang-tidy",
    "--enable-config",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--header-insertion=iwyu",
  },       
  on_attach = function(client, buffnr) 
    nmap('<A-o>', ':ClangdSwitchSourceHeader<CR>')
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {noremap=true, silent=true, buffer=buffnr})
  end
})

-- lightbulb
require("nvim-lightbulb").setup({
  autocmd = { enabled = true },
  sign = { enabled = false },
  float = { enabled = true }
})
