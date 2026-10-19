-- conform.nvim replaces neoformat / codefmt. <localleader>fo formats with the
-- tool listed for the filetype, falling back to the LSP server's formatter.
return {
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo', 'Format' },
  keys = {
    {
      '<localleader>fo',
      function() require('conform').format({ lsp_format = 'fallback' }) end,
      mode = { 'n', 'v' },
      desc = 'format buffer / selection',
    },
  },
  opts = {
    formatters_by_ft = {
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      clojure = { 'cljfmt' },
      sql = { 'pg_format' },
      python = { 'black' },
      elm = { 'elm_format' },
      zig = { 'zigfmt' },
    },
    formatters = {
      pg_format = { prepend_args = { '--comma-start', '--comma-break' } },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)
    vim.api.nvim_create_user_command('Format', function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = { start = { args.line1, 0 }, ['end'] = { args.line2, end_line:len() } }
      end
      require('conform').format({ lsp_format = 'fallback', range = range })
    end, { range = true })
  end,
}
