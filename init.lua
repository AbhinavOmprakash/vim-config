-- Entry point. Everything lives under lua/config (editor settings) and
-- lua/plugins (one file per area, auto-loaded by lazy.nvim).
require('config.options')
require('config.lazy')
require('config.keymaps')
require('config.autocmds')
