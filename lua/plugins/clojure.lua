return {
  {
    'Olical/conjure',
    lazy = false,
    init = function()
      vim.g['conjure#client#sql#stdio#command'] = 'psql postgresql://postgres:postgres@localhost:5432/mydb'
    end,
  },
  { 'guns/vim-sexp', ft = { 'clojure', 'scheme', 'lisp', 'fennel' } },
  { 'tpope/vim-sexp-mappings-for-regular-people', ft = { 'clojure', 'scheme', 'lisp', 'fennel' }, dependencies = { 'guns/vim-sexp' } },

  -- :Dispatch / :Make, async builds into the quickfix list
  { 'tpope/vim-dispatch', cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } },
  { 'radenling/vim-dispatch-neovim', dependencies = { 'tpope/vim-dispatch' }, lazy = false },

  -- :Clj / :Lein / :Boot start an nrepl that conjure connects to
  { 'clojure-vim/vim-jack-in', dependencies = { 'tpope/vim-dispatch' }, cmd = { 'Clj', 'Lein', 'Boot' } },
}
