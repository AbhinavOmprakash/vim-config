return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('gruvbox').setup({})
      vim.cmd.colorscheme('gruvbox')
    end,
  },

  { 'nvim-tree/nvim-web-devicons', lazy = true },

  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
      -- cmake-tools status, shown only once the plugin is loaded and the cwd is a cmake project
      local function cmake()
        local ct = package.loaded['cmake-tools']
        if not ct or not ct.is_cmake_project() then return '' end
        return ' ' .. (ct.get_build_type() or '?') .. ' : ' .. (ct.get_build_target() or '?')
      end
      return {
        options = { theme = 'gruvbox', globalstatus = true },
        sections = {
          lualine_a = { 'mode' },
          -- branch intentionally hidden (airline had it disabled too)
          lualine_b = { 'diff', 'diagnostics' },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { cmake, 'lsp_status', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
    end,
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'helix',
      spec = {
        { '<localleader>a', group = 'arrow' },
        { '<localleader>c', group = 'cmake' },
        { '<localleader>d', group = 'debug / dash' },
        { '<localleader>f', group = 'find / format' },
        { '<localleader>g', group = 'goto / git' },
        { '<localleader>h', group = 'hunks' },
        { '<localleader>q', group = 'quickfix' },
        { '<localleader>z', group = 'zig' },
      },
    },
  },

  -- dotted indent guides, brighter dashed line for the current scope
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      indent = { char = '\u{250a}', tab_char = '\u{250a}' },
      whitespace = { remove_blankline_trail = true },
      scope = {
        enabled = true,
        char = '\u{2506}',
        show_start = false,
        show_end = false,
        include = {
          node_type = {
            cpp = { 'function_definition', 'class_specifier', 'struct_specifier',
                    'namespace_definition', 'for_statement', 'while_statement',
                    'if_statement', 'switch_statement', 'compound_statement',
                    'lambda_expression' },
            c   = { 'function_definition', 'struct_specifier', 'for_statement',
                    'while_statement', 'if_statement', 'switch_statement',
                    'compound_statement' },
          },
        },
      },
      exclude = {
        filetypes = { 'help', 'NvimTree', 'lazygit', 'dashboard', 'lazy', 'mason',
                      'dapui_scopes', 'dapui_breakpoints', 'dapui_stacks',
                      'dapui_watches', 'dap-repl', 'org', 'fzf' },
        buftypes = { 'terminal', 'nofile', 'quickfix', 'prompt' },
      },
    },
    config = function(_, opts)
      require('ibl').setup(opts)
      -- gruvbox-matching colors: faint dots, slightly brighter for the active scope
      local function colors()
        vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#3c3836', nocombine = true })
        vim.api.nvim_set_hl(0, 'IblWhitespace', { fg = '#3c3836', nocombine = true })
        vim.api.nvim_set_hl(0, 'IblScope', { fg = '#7c6f64', nocombine = true })
      end
      colors()
      vim.api.nvim_create_autocmd('ColorScheme', { callback = colors })
    end,
  },

  -- colour hex codes inline
  {
    'catgoose/nvim-colorizer.lua',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = { user_default_options = { names = false } },
  },
}
