local map = vim.keymap.set

map('i', 'jk', '<Esc>')

-- quickfix navigation (cmake / dispatch dump build errors here)
map('n', ']q', '<cmd>cnext<CR>', { silent = true, desc = 'next quickfix' })
map('n', '[q', '<cmd>cprevious<CR>', { silent = true, desc = 'prev quickfix' })
map('n', '<localleader>qq', '<cmd>copen<CR>', { silent = true, desc = 'open quickfix' })
map('n', '<localleader>qc', '<cmd>cclose<CR>', { silent = true, desc = 'close quickfix' })

-- Dash.app docs (replaces dash.nvim, which was never on the runtimepath)
local function dash(query)
  vim.ui.open('dash://' .. query)
end
map('n', '<localleader>dd', function() dash(vim.bo.filetype .. ':' .. vim.fn.expand('<cword>')) end,
  { desc = 'dash: word (filetype scoped)' })
map('n', '<localleader>dw', function() dash(vim.fn.expand('<cword>')) end,
  { desc = 'dash: word' })

vim.api.nvim_create_user_command('Vimrc', 'vsplit $MYVIMRC', {})
vim.api.nvim_create_user_command('Hs', 'split', {})

-- clojure macros (snitch). `jk` inside them is the insert-mode escape above.
vim.fn.setreg('s', [==[m8gg0)o(require 'jkf'xi[snitch.core :refer [defn* defmethod* *fn *let]])jk;ee`8]==])
vim.fn.setreg('n', [==[m8gg0>I(:require [snitch.core :refer-macros [defn* defmethod* *fn *let]])jk;er`8]==])
vim.fn.setreg('e', [==[ysaf(f(i'jkx(amacroexpand-1jk]==])
-- transpose s-exp: (a (b (c))) -> (b (a (c)))
vim.fn.setreg('t', [==[ld$a jkWpld$((p((]==])
