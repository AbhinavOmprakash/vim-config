return {
  {
    'ziglang/zig.vim',
    ft = 'zig',
    init = function() vim.g.zig_fmt_autosave = 1 end,
  },

  {
    'elmcast/elm-vim',
    ft = 'elm',
    init = function() vim.g.elm_setup_keybindings = 0 end,
  },

  {
    'ray-x/go.nvim',
    dependencies = { 'ray-x/guihua.lua' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()',
    opts = { lsp_cfg = false }, -- gopls is managed by mason-lspconfig
  },

  {
    'nvim-orgmode/orgmode',
    ft = 'org',
    cmd = { 'Org' },
    opts = {
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',
    },
  },

  { 'aklt/plantuml-syntax', ft = 'plantuml' },
  {
    'weirongxu/plantuml-previewer.vim',
    ft = 'plantuml',
    dependencies = { 'tyru/open-browser.vim' },
  },

  { 'mzarnitsa/psql', ft = 'sql' },

  { 'tpope/vim-dadbod', cmd = 'DB' },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = { 'tpope/vim-dadbod' },
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    init = function() vim.g.db_ui_execute_on_save = 0 end,
  },

  { 'tpope/vim-rails', ft = { 'ruby', 'eruby' } },
}
