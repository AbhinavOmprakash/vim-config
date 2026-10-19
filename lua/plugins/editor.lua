return {
  {
    'folke/flash.nvim',
    -- char mode (labels on f/t) stays off: the old config never called setup(), so it was never on
    opts = { modes = { char = { enabled = false } } },
    keys = {
      { '<localleader>fw', function() require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'flash jump' },
    },
  },

  -- multiple cursors, same <C-n> flow as vim-multiple-cursors
  { 'mg979/vim-visual-multi', event = 'VeryLazy' },

  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },

  -- ys / cs / ds, same keys as vim-surround
  { 'kylechui/nvim-surround', event = 'VeryLazy', opts = {} },

  {
    'mbbill/undotree',
    keys = { { '<localleader>ut', '<cmd>UndotreeToggle<CR>', desc = 'undotree' } },
  },

  {
    'otavioschwanck/arrow.nvim',
    event = 'VeryLazy',
    opts = {
      show_icons = true,
      always_show_path = false,
      separate_by_branch = false,
      global_bookmarks = true,
      leader_key = ';af',
      buffer_leader_key = ';ab',
      mappings = {
        toggle = 's',
        next_item = ']',
        prev_item = '[',
        quit = 'q',
        delete_mode = 'd',
        open_vertical = 'v',
        open_horizontal = '-',
      },
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
    keys = {
      { '<localleader>nn', '<cmd>NvimTreeToggle<CR>', desc = 'file tree' },
      { '<localleader>nf', '<cmd>NvimTreeFindFile<CR>', desc = 'file tree: reveal current file' },
    },
    opts = {
      view = { width = 35 },
      renderer = { group_empty = true, highlight_git = 'name' },
      git = { enable = true },
      filters = { dotfiles = false, git_ignored = false },
      update_focused_file = { enable = true },
    },
  },

  -- rainbow parens via treesitter (replaces luochen1990/rainbow)
  { 'HiPhish/rainbow-delimiters.nvim', event = { 'BufReadPost', 'BufNewFile' } },

  { 'tpope/vim-projectionist', event = 'VeryLazy' },
}
