local aug = function(name) return vim.api.nvim_create_augroup('user_' .. name, { clear = true }) end
local au = vim.api.nvim_create_autocmd

-- autosave when leaving insert mode or text changes in normal mode
au({ 'InsertLeave', 'TextChanged' }, {
  group = aug('autosave'),
  callback = function(ev)
    local buf = ev.buf
    if vim.bo[buf].buftype == '' and vim.bo[buf].modifiable and vim.bo[buf].modified
        and vim.api.nvim_buf_get_name(buf) ~= '' then
      vim.cmd('silent! write')
    end
  end,
})

-- treat .h (and template impl files) as c++ rather than c, otherwise clangd
-- parses headers as C and every template/namespace becomes an error
vim.filetype.add({
  extension = { h = 'cpp', tpp = 'cpp', ipp = 'cpp', inl = 'cpp' },
})

local ft = aug('filetype')

au('FileType', {
  group = ft,
  pattern = 'markdown',
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 120
    vim.opt_local.formatoptions:append('t')
    vim.opt_local.colorcolumn = '120'
  end,
})

-- c / c++: cindent instead of smartindent (real C-family rules).
-- shiftwidth=2 matches LLVM/Google style; bump to 4 if your .clang-format says so.
au('FileType', {
  group = ft,
  pattern = { 'c', 'cpp', 'objc', 'objcpp' },
  callback = function()
    local l = vim.opt_local
    l.cindent = true
    l.expandtab = true
    l.shiftwidth = 2
    l.softtabstop = 2
    l.tabstop = 2
    l.textwidth = 0
    l.colorcolumn = '100'
    l.commentstring = '// %s'
    -- treesitter folds land on real scopes (functions/classes/namespaces)
    l.foldmethod = 'expr'
    l.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    l.foldenable = true
    l.foldlevel = 99
    l.foldnestmax = 10
    l.foldcolumn = '1'
  end,
})

au('FileType', {
  group = ft,
  pattern = 'zig',
  callback = function()
    vim.keymap.set('n', '<localleader>zt', '<cmd>Dispatch zig test %<CR>', { buffer = true, desc = 'zig test' })
    vim.keymap.set('n', '<localleader>zb', '<cmd>Dispatch zig build<CR>', { buffer = true, desc = 'zig build' })
  end,
})

au('FileType', {
  group = ft,
  pattern = 'sql',
  callback = function()
    vim.keymap.set({ 'n', 'v' }, '<localleader>S', '<Plug>(DBUI_ExecuteQuery)', { buffer = true, silent = true, desc = 'dbui: run query' })
  end,
})
