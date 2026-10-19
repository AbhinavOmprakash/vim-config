-- nvim-treesitter `main` branch: it only installs parsers/queries. Highlight,
-- indent and folds are enabled with core nvim APIs below.
local parsers = {
  'c', 'cpp', 'cmake', 'make', 'lua', 'vim', 'vimdoc', 'query',
  'clojure', 'python', 'go', 'gomod', 'gosum', 'zig', 'elm', 'ocaml', 'ruby',
  'javascript', 'typescript', 'tsx', 'json', 'yaml', 'toml',
  'markdown', 'markdown_inline', 'bash', 'sql', 'html', 'css',
  'dockerfile', 'diff', 'gitcommit', 'git_rebase', 'regex',
}

-- treesitter indentexpr is skipped here; cindent is better for C-family code
local no_ts_indent = { c = true, cpp = true, objc = true, objcpp = true }

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')
      ts.setup({})
      ts.install(parsers)

      local installing = {}
      local available -- set of languages nvim-treesitter can install, built lazily
      local function can_install(lang)
        if not available then
          available = {}
          for _, l in ipairs(ts.get_available()) do available[l] = true end
        end
        return available[lang]
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('user_treesitter', { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang then return end
          if vim.treesitter.language.add(lang) then
            vim.treesitter.start(ev.buf, lang)
            if not no_ts_indent[ev.match] then
              vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          elseif can_install(lang) and not installing[lang] then
            -- parser missing: install once in the background, then attach to this buffer
            installing[lang] = true
            local ok, task = pcall(ts.install, { lang })
            if ok and task and task.await then
              task:await(function()
                installing[lang] = nil
                if vim.api.nvim_buf_is_valid(ev.buf) and vim.treesitter.language.add(lang) then
                  vim.treesitter.start(ev.buf, lang)
                end
              end)
            end
          end
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    init = function() vim.g.no_plugin_maps = true end,
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })
      local sel = function(q) return function() require('nvim-treesitter-textobjects.select').select_textobject(q, 'textobjects') end end
      local mv = require
      local map = vim.keymap.set
      map({ 'x', 'o' }, 'af', sel('@function.outer'), { desc = 'a function' })
      map({ 'x', 'o' }, 'if', sel('@function.inner'), { desc = 'inner function' })
      map({ 'x', 'o' }, 'ac', sel('@class.outer'), { desc = 'a class' })
      map({ 'x', 'o' }, 'ic', sel('@class.inner'), { desc = 'inner class' })
      map({ 'x', 'o' }, 'aa', sel('@parameter.outer'), { desc = 'a argument' })
      map({ 'x', 'o' }, 'ia', sel('@parameter.inner'), { desc = 'inner argument' })
      local function move(fn, q)
        return function() mv('nvim-treesitter-textobjects.move')[fn](q, 'textobjects') end
      end
      map({ 'n', 'x', 'o' }, ']f', move('goto_next_start', '@function.outer'), { desc = 'next function' })
      map({ 'n', 'x', 'o' }, '[f', move('goto_previous_start', '@function.outer'), { desc = 'prev function' })
      map({ 'n', 'x', 'o' }, ']]', move('goto_next_start', '@class.outer'), { desc = 'next class' })
      map({ 'n', 'x', 'o' }, '[[', move('goto_previous_start', '@class.outer'), { desc = 'prev class' })
    end,
  },
}
