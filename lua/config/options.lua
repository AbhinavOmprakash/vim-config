-- leaders must be set before plugins load
vim.g.maplocalleader = ';'

-- nvim-tree replaces netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- macOS: point clang tooling at the CommandLineTools SDK so clangd finds libc++ headers
if vim.fn.has('macunix') == 1 then
  local sdk = '/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk'
  vim.env.SDKROOT = sdk
  vim.env.CXXFLAGS = '-I' .. sdk .. '/usr/include/c++/v1'
  vim.env.CFLAGS = '-isysroot ' .. sdk
end

local o = vim.opt

o.autoindent = true
o.smartindent = true
o.mouse = 'a'
o.swapfile = false
o.number = true
o.relativenumber = true
o.wrap = false
o.list = false

-- faster CursorHold (lsp highlight / diagnostics feel sluggish at the default 4s)
o.updatetime = 300
-- stop the gutter from shifting text as diagnostics appear
o.signcolumn = 'yes'

o.termguicolors = true
o.background = 'dark'

-- folds: start every file fully open, fold with za / zR / zM
o.foldlevelstart = 99
o.foldlevel = 99
o.foldenable = false

o.ignorecase = true
o.smartcase = true
o.undofile = true

o.clipboard = 'unnamed,unnamedplus'

-- ocaml: ocp-indent ships a vim plugin inside the opam switch
local ocp = vim.fn.expand('~/.opam/default/share/ocp-indent/vim')
if vim.fn.isdirectory(ocp) == 1 then
  o.rtp:prepend(ocp)
end

-- shared rg flags: hide noise from the file finder and live grep
vim.g.rg_ignore_globs = {
  '--glob', '!.git/*',
  '--glob', '!.venv/*',
  '--glob', '!node_modules/*',
  '--glob', '!__pycache__/*',
  '--glob', '!build/*',
}
