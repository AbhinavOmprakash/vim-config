local function rg_globs()
  return table.concat(vim.g.rg_ignore_globs, ' ')
end

return {
  'ibhagwan/fzf-lua',
  -- needs the fzf binary on PATH (brew install fzf)
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'FzfLua',
  keys = {
    { '<localleader>ff', function() require('fzf-lua').files() end, desc = 'find files' },
    { '<localleader>fe', function() require('fzf-lua').live_grep() end, desc = 'live grep' },
    { '<localleader>fb', function() require('fzf-lua').buffers() end, desc = 'buffers' },
    { '<localleader>fr', function() require('fzf-lua').resume() end, desc = 'resume last picker' },
    { '<localleader>fs', function() require('fzf-lua').lsp_document_symbols() end, desc = 'document symbols' },
    { '<localleader>fS', function() require('fzf-lua').lsp_live_workspace_symbols() end, desc = 'workspace symbols' },
    { '<localleader>fd', function() require('fzf-lua').diagnostics_document() end, desc = 'diagnostics' },
    {
      '<localleader>fn',
      function()
        require('fzf-lua').grep({
          search = [[\(ns\s]],
          no_esc = true,
          prompt = 'Clojure NS> ',
          rg_opts = "--column --line-number --no-heading --color=always --smart-case --glob '*.clj' --glob '*.cljs' --glob '*.cljc' -e",
        })
      end,
      desc = 'find clojure namespace',
    },
  },
  opts = function()
    return {
      winopts = { preview = { layout = 'vertical', vertical = 'down:50%' } },
      files = {
        cmd = 'rg --files --hidden --follow ' .. rg_globs(),
      },
      grep = {
        rg_opts = '--column --line-number --no-heading --color=always --smart-case --max-columns=4096 '
          .. '--hidden --follow --type-not sql ' .. rg_globs() .. ' -e',
      },
    }
  end,
}
