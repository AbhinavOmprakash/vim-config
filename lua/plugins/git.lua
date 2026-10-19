return {
  { 'tpope/vim-fugitive', cmd = { 'G', 'Git', 'Gdiffsplit', 'Gvdiffsplit', 'Gread', 'Gwrite', 'Gblame', 'GBrowse' } },
  { 'tpope/vim-rhubarb', dependencies = { 'tpope/vim-fugitive' }, cmd = 'GBrowse' },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      on_attach = function(buf)
        local gs = require('gitsigns')
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
        end
        map('n', ']c', function()
          if vim.wo.diff then vim.cmd.normal({ ']c', bang = true }) else gs.nav_hunk('next') end
        end, 'next hunk')
        map('n', '[c', function()
          if vim.wo.diff then vim.cmd.normal({ '[c', bang = true }) else gs.nav_hunk('prev') end
        end, 'prev hunk')
        map('n', '<localleader>hp', gs.preview_hunk, 'preview hunk')
        map('n', '<localleader>hs', gs.stage_hunk, 'stage hunk')
        map('n', '<localleader>hu', gs.undo_stage_hunk, 'undo stage hunk')
        map('n', '<localleader>hr', gs.reset_hunk, 'reset hunk')
        map('n', '<localleader>hb', function() gs.blame_line({ full = true }) end, 'blame line')
      end,
    },
  },

  {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'LazyGit', 'LazyGitCurrentFile', 'LazyGitFilter' },
    keys = { { '<localleader>gg', '<cmd>LazyGit<CR>', desc = 'lazygit' } },
  },

  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  },

  {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    dependencies = { 'nvim-lua/plenary.nvim', 'ibhagwan/fzf-lua', 'nvim-tree/nvim-web-devicons' },
    opts = { picker = 'fzf-lua' },
  },
}
