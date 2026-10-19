-- Native LSP (nvim 0.11+ vim.lsp.config / vim.lsp.enable), servers installed by mason,
-- completion by blink.cmp. Replaces coc.nvim.
return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    event = 'InsertEnter',
    opts = {
      -- <CR> accepts, <C-n>/<C-p> move, <C-space> toggles docs, <C-e> hides
      keymap = { preset = 'enter' },
      appearance = { nerd_font_variant = 'mono' },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        list = { selection = { preselect = true, auto_insert = false } },
      },
      signature = { enabled = true },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
  },

  { 'mason-org/mason.nvim', lazy = false, opts = {} },

  -- lua_ls knows the nvim API + plugin types while editing this config
  { 'folke/lazydev.nvim', ft = 'lua', opts = {} },

  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = { 'saghen/blink.cmp', 'mason-org/mason.nvim', 'mason-org/mason-lspconfig.nvim' },
    config = function()
      ------------------------------------------------------------------ diagnostics
      vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '⚠',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
        },
        virtual_text = { prefix = '➤', spacing = 2 },
        float = { border = 'rounded', source = true },
      })

      ------------------------------------------------------------------ servers
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      vim.lsp.config('clangd', {
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
          '--fallback-style=llvm',
          -- let clangd ask the real compilers for their system include paths
          '--query-driver=/usr/bin/clang*,/opt/homebrew/bin/*,/opt/homebrew/opt/llvm/bin/*',
        },
      })

      vim.lsp.config('clojure_lsp', {
        init_options = { ['ignore-classpath-directories'] = true },
      })

      vim.lsp.config('lua_ls', {
        settings = { Lua = { workspace = { checkThirdParty = false }, telemetry = { enable = false } } },
      })

      vim.lsp.config('pyright', {
        settings = {
          python = {
            analysis = {
              inlayHints = {
                variableTypes = false, functionReturnTypes = false,
                callArgumentNames = false, parameterNames = false, pytestParameters = false,
              },
            },
          },
        },
      })

      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd', 'clojure_lsp', 'jsonls', 'neocmake', 'pyright', 'lua_ls', 'gopls' },
        automatic_enable = true,
      })

      -- servers that live outside mason
      if vim.fn.executable('ocamllsp') == 1 then vim.lsp.enable('ocamllsp') end

      ------------------------------------------------------------------ keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then return end
          local buf = ev.buf
          local function map(lhs, rhs, desc, mode)
            vim.keymap.set(mode or 'n', lhs, rhs, { buffer = buf, silent = true, desc = desc })
          end

          map('<localleader>gd', vim.lsp.buf.definition, 'goto definition')
          map('<localleader>gr', vim.lsp.buf.references, 'references (quickfix)')
          map('<localleader>gi', vim.lsp.buf.implementation, 'goto implementation')
          map('<localleader>gy', vim.lsp.buf.type_definition, 'goto type definition')
          map('<localleader>rn', vim.lsp.buf.rename, 'rename symbol')
          map('<localleader>ca', vim.lsp.buf.code_action, 'code action', { 'n', 'v' })
          map('K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, 'hover')
          map('[g', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'prev diagnostic')
          map(']g', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'next diagnostic')
          map('<localleader>ih', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
          end, 'toggle inlay hints')

          if client.name == 'clangd' then
            map('<localleader>gh', '<cmd>LspClangdSwitchSourceHeader<CR>', 'switch source/header')
            map('<localleader>gH', '<cmd>vsplit | LspClangdSwitchSourceHeader<CR>', 'switch source/header (vsplit)')
          end

          -- highlight the symbol under the cursor and its references
          if client:supports_method('textDocument/documentHighlight') then
            local hl = vim.api.nvim_create_augroup('user_lsp_highlight_' .. buf, { clear = true })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              group = hl, buffer = buf, callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              group = hl, buffer = buf, callback = vim.lsp.buf.clear_references,
            })
          end

          if client:supports_method('textDocument/codeLens') then
            vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
              buffer = buf, callback = function() vim.lsp.codelens.refresh({ bufnr = buf }) end,
            })
          end
        end,
      })
    end,
  },
}
