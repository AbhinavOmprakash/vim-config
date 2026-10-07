let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Fix macOS missing C++ headers (macOS only)
if has('macunix')
  let $SDKROOT = '/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk'
  let $CXXFLAGS = '-I/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/v1'
  let $CFLAGS = '-isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk'
endif


" elm plugin wants this
" c/cpp added: treesitter handles their syntax now, polyglot conflicts with it
let g:polyglot_disabled = ['elm', 'python', 'c', 'cpp']

call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'Olical/conjure'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rails'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'guns/vim-sexp',    {'for': 'clojure'}
Plug 'morhetz/gruvbox'
Plug 'kdheepak/lazygit.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ibhagwan/fzf-lua'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-surround'
Plug 'ncm2/float-preview.nvim'
Plug 'jiangmiao/auto-pairs', { 'tag': 'v2.0.0' }
Plug 'mbbill/undotree'
Plug 'tpope/vim-dispatch'
Plug 'clojure-vim/vim-jack-in'
Plug 'radenling/vim-dispatch-neovim'
Plug 'luochen1990/rainbow'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'
Plug 'nvim-lua/plenary.nvim'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-projectionist'
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}
Plug 'aklt/plantuml-syntax' " plantuml
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'
Plug 'mzarnitsa/psql'
Plug 'norcalli/nvim-colorizer.lua' " colorizer for hex codes
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'pwntester/octo.nvim'
Plug 'elmcast/elm-vim'
Plug 'duane9/nvim-rg'
Plug 'folke/flash.nvim'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'otavioschwanck/arrow.nvim'
" js support
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'nvim-orgmode/orgmode'
Plug 'ziglang/zig.vim'
Plug 'sindrets/diffview.nvim'
" c/c++ support
Plug 'Civitasv/cmake-tools.nvim'      " :CMakeGenerate / :CMakeBuild / :CMakeRun
Plug 'mfussenegger/nvim-dap'          " debugging
Plug 'nvim-neotest/nvim-nio'          " dap-ui dependency
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
call plug#end()


set autoindent
set smartindent
set mouse=a
set noswapfile
set number relativenumber
set nowrap

" faster CursorHold (coc highlight/diagnostics feel sluggish at the default 4s)
set updatetime=300
" stop the gutter from shifting text left/right as diagnostics appear
set signcolumn=yes

set termguicolors
set background=dark
colorscheme gruvbox

" prevent highlighting tabs and otherspaces
set nolist
hi  TabChar             ctermbg=1
hi  TrailingSpaceChar   ctermbg=2
hi  NBSP                ctermbg=3
syn match TabChar " "
syn match TrailingSpaceChar " *$"
syn match NBSP " "



imap jk <Esc>
"tnoremap jk <C-\><C-n>
let maplocalleader=";"

let g:ale_lint_on_enter = 1
let g:ale_lint_on_text_changed = 'always'
" only run the linters listed here -- otherwise ALE auto-detects gcc/clang/
" cppcheck for c/cpp and duplicates every clangd diagnostic
let g:ale_linters_explicit = 1
let g:ale_linters = {'clojure': ['clj-kondo'], 'c': [], 'cpp': []}

" Enable signs in the gutter
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

" Enable highlighting of problems
let g:ale_set_highlights = 1

" Enable virtual text (inline errors)
let g:ale_virtualtext_cursor = 1

" Format for virtual text
let g:ale_virtualtext_prefix = '➤ '

" Show error message format
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" DADBOD don't execute sql queries on save
let g:db_ui_execute_on_save=0
autocmd FileType sql nnoremap <silent> <localleader>S <Plug>(DBUI_ExecuteQuery)
autocmd FileType sql vnoremap <silent> <localleader>S <Plug>(DBUI_ExecuteQuery)

" hide gitbranch
let g:airline#extensions#branch#enabled = 0

" elm plugin has incompatible keybindings
let g:elm_setup_keybindings = 0

let g:rainbow_active = 1

let g:conjure#client#sql#stdio#command="psql postgresql://postgres:postgres@localhost:5432/mydb"

command! Vimrc :vs $MYVIMRC
command! Hs :split
set lazyredraw
set smartcase
set ignorecase
set undofile


"ocaml
set rtp^="~/.opam/default/share/ocp-indent/vim"

nnoremap <localleader>gg :LazyGit<CR>

nnoremap <localleader>nn :NERDTreeToggle<CR>
nnoremap <localleader>ff :FZF<CR>
nnoremap <localleader>fe :Rg<space>


nnoremap <localleader>fw :lua require('flash').jump()<CR>

nmap <silent> <localleader>gr <Plug>(coc-references)
nmap <silent> <localleader>rn <Plug>(coc-rename)
nmap <silent> <localleader>gd <Plug>(coc-definition)
nmap <silent> <localleader>ut :UndotreeToggle<CR>

" more coc mappings that pay off in c++ specifically
nmap <silent> <localleader>gi <Plug>(coc-implementation)
nmap <silent> <localleader>gy <Plug>(coc-type-definition)
nmap <silent> <localleader>ca <Plug>(coc-codeaction-cursor)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" quickfix navigation (dispatch dumps build errors here)
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> <localleader>qq :copen<CR>
nnoremap <silent> <localleader>qc :cclose<CR>

"Dash
if has('macunix')
  Plug 'mrjones2014/dash.nvim', { 'do': 'make install' }
  nnoremap <localleader>dd :Dash!<CR>
  nnoremap <localleader>dw :DashWord!<CR>
endif

set clipboard=unnamed
set clipboard+=unnamedplus


autocmd FileType clojure nnoremap <localleader>fo :Neoformat cljfmt<CR>
autocmd FileType sql nnoremap <localleader>fo :Neoformat<CR>
autocmd FileType python nnoremap <localleader>fo :Neoformat black<CR>
autocmd FileType elm nnoremap <localleader>fo :ElmFormat<CR>
autocmd FileType zig nnoremap <localleader>fo :Neoformat zigfmt<CR>
autocmd FileType zig nnoremap <localleader>zt :Dispatch zig test %<CR>
autocmd FileType zig nnoremap <localleader>zb :Dispatch zig build<CR>
" wrap lines for markdown
autocmd FileType markdown setlocal wrap linebreak textwidth=120 formatoptions+=t colorcolumn=120

"Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:neoformat_enabled_sql = ['pg_format']

let g:neoformat_sql_pg_format = {
      \ 'exe': 'pg_format',
      \ 'stdin': 1,
      \ 'args': ['--comma-start', '--comma-break']
      \ }

let g:neoformat_clojure_cljstyle = {
    \ 'exe': 'cljstyle',
    \ 'args': ['pipe'],
    \ 'stdin': 1,
    \ }

let g:neoformat_clojure_cljfmt = {
    \ 'exe': 'cljfmt',
    \ 'args': ['fix', '-'],
    \ 'stdin': 1,
    \ }

let g:neoformat_enabled_clojure = ['cljfmt', 'cljstyle']

let g:neoformat_enabled_zig = ['zigfmt']
let g:neoformat_zig_zigfmt = {
    \ 'exe': 'zig',
    \ 'args': ['fmt', '--stdin'],
    \ 'stdin': 1,
    \ }
" Zig configuration
let g:zig_fmt_autosave = 1


" ============================================================================
" C / C++
" ============================================================================

" coc extensions installed automatically on first launch.
" coc-clangd needs a clangd binary: `:CocCommand clangd.install` grabs one,
" or `brew install llvm` and set clangd.path in :CocConfig.
let g:coc_global_extensions = ['coc-clangd', 'coc-json', 'coc-cmake']

" indentation: cindent instead of smartindent, real C-family rules.
" shiftwidth=2 matches LLVM/Google style -- bump to 4 if your .clang-format says so.
autocmd FileType c,cpp,objc,objcpp setlocal
      \ cindent
      \ expandtab
      \ shiftwidth=2
      \ softtabstop=2
      \ tabstop=2
      \ textwidth=0
      \ colorcolumn=100
      \ commentstring=//\ %s

" clang-format via neoformat. picks up .clang-format from the project root.
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--assume-filename=%:t'],
    \ 'stdin': 1,
    \ }
let g:neoformat_c_clangformat = g:neoformat_cpp_clangformat

autocmd FileType c,cpp nnoremap <buffer> <localleader>fo :Neoformat clangformat<CR>

" jump between header and source (clangd knows the pairing)
autocmd FileType c,cpp nnoremap <buffer> <silent> <localleader>gh
      \ :CocCommand clangd.switchSourceHeader<CR>
autocmd FileType c,cpp nnoremap <buffer> <silent> <localleader>gH
      \ :CocCommand clangd.switchSourceHeader vsplit<CR>
" toggle inlay hints (types on auto, param names at call sites)
autocmd FileType c,cpp nnoremap <buffer> <silent> <localleader>ih
      \ :CocCommand document.toggleInlayHint<CR>

" build / run / test via dispatch -- errors land in the quickfix list.
" these assume a cmake project with build/ as the binary dir; :CMake* commands
" come from cmake-tools.nvim and are smarter if you configure it per-project.
autocmd FileType c,cpp nnoremap <buffer> <localleader>cg
      \ :Dispatch cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON<CR>
autocmd FileType c,cpp nnoremap <buffer> <localleader>cb :Dispatch cmake --build build -j<CR>
autocmd FileType c,cpp nnoremap <buffer> <localleader>ct :Dispatch ctest --test-dir build --output-on-failure<CR>
autocmd FileType c,cpp nnoremap <buffer> <localleader>cr :CMakeRun<CR>
autocmd FileType c,cpp nnoremap <buffer> <localleader>cc :CMakeSelectBuildTarget<CR>

" treat .h as c++ rather than c -- otherwise clangd parses headers as C and
" every template/namespace becomes an error
autocmd BufNewFile,BufRead *.h setfiletype cpp
autocmd BufNewFile,BufRead *.tpp,*.ipp,*.inl setfiletype cpp

lua << EOF
require('orgmode').setup({
  org_agenda_files = '~/orgfiles/**/*',
  org_default_notes_file = '~/orgfiles/refile.org',
})
EOF

" treesitter: better highlighting, and %-matching / text objects that
" understand c++ scopes. wrapped in pcall so a missing plugin can't break startup.
lua << EOF
pcall(function()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'c', 'cpp', 'cmake', 'make', 'lua', 'vim', 'vimdoc' },
    auto_install = false,
    highlight = {
      enable = true,
      -- only take over the filetypes disabled in polyglot above
      disable = function(lang, _)
        return not vim.tbl_contains({ 'c', 'cpp', 'cmake', 'make' }, lang)
      end,
    },
    indent = { enable = true, disable = { 'c', 'cpp' } }, -- cindent is better here
  })
end)
EOF

" cmake-tools: :CMakeGenerate, :CMakeBuild, :CMakeRun, :CMakeDebug
lua << EOF
pcall(function()
  require('cmake-tools').setup({
    cmake_build_directory = 'build',
    cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON' },
    cmake_soft_link_compile_commands = true, -- symlink compile_commands.json to project root for clangd
    cmake_dap_configuration = {
      name = 'cpp',
      type = 'gdb',
      request = 'launch',
    },
  })
end)
EOF

" debugging: needs codelldb on PATH (`brew install llvm` ships lldb-dap, or
" grab the vscode-lldb release and point `command` at the codelldb binary)
lua << EOF
pcall(function()
  local dap = require('dap')
  local dapui = require('dapui')

  dapui.setup()
  require('nvim-dap-virtual-text').setup()

  dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '-i', 'dap' },
  }

  dap.configurations.cpp = {
    {
      name = 'Launch',
      type = 'gdb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
    },
  }
  dap.configurations.c = dap.configurations.cpp

  dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
  dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
  dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

  local map = vim.keymap.set
  map('n', '<localleader>db', dap.toggle_breakpoint, { desc = 'dap breakpoint' })
  map('n', '<localleader>dB', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
  end, { desc = 'dap conditional breakpoint' })
  map('n', '<localleader>dc', dap.continue,          { desc = 'dap continue' })
  map('n', '<localleader>ds', dap.step_over,         { desc = 'dap step over' })
  map('n', '<localleader>di', dap.step_into,         { desc = 'dap step into' })
  map('n', '<localleader>do', dap.step_out,          { desc = 'dap step out' })
  map('n', '<localleader>dx', dap.terminate,         { desc = 'dap terminate' })
  map('n', '<localleader>du', dapui.toggle,          { desc = 'dap ui' })
end)
EOF

filetype plugin indent on
let g:NERDCreateDefaultMappings = 1

"tab completion for coc
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"


" add snitch
let @s = "m8gg0)o(require 'jkf'xi[snitch.core :refer [defn* defmethod* *fn *let]])jk;ee`8"
let @n = "m8gg0>I(:require [snitch.core :refer-macros [defn* defmethod* *fn *let]])jk;er`8"
let @e = "ysaf(f(i'jkx(amacroexpand-1jk"
let @t = "ld$a jkWpld$((p((" "transpose s-exp? (a (b (dasdf))) to (b (a (dasdf)))


" Autosave when leaving insert mode or text changes in normal mode
autocmd InsertLeave,TextChanged * silent! write


" to hide .venv files from finder
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --glob "!.venv/*" --glob "!node_modules/*" --glob "!__pycache__/*" --glob "!build/*"'
" to hide files from finder
let g:rg_command = 'rg --vimgrep --type-not sql --smart-case --hidden --follow --glob "!.git/*" --glob "!.venv/*" --glob "!__pycache__/*" --glob "!build/*"'


lua << EOF
require('arrow').setup({
  show_icons = true,
  always_show_path = false,
  separate_by_branch = false,
  global_bookmarks = true,        -- files saved globally across all projects
  leader_key = ';af',    -- arrow file
  buffer_leader_key = ';ab', -- arrow buffer
  mappings = {
    toggle = 's',                 -- save/remove current file
    next_item = ']',              -- cycle to next bookmark
    prev_item = '[',              -- cycle to prev bookmark
    quit = 'q',
    delete_mode = 'd',
    open_vertical = 'v',
    open_horizontal = '-',
  }
})
EOF


" find namespace for clojure
lua << EOF
vim.keymap.set('n', '<localleader>fn', function()
  require('fzf-lua').grep({
    search = [[\(ns\s]],
    no_esc = true,
    prompt = 'Clojure NS> ',
    rg_opts = "--glob '*.clj' --glob '*.cljs' --glob '*.cljc'",
  })
end, { desc = 'Find Clojure namespace' })
EOF

lua << EOF
require('telescope').setup({
  defaults = {
    -- use your terminal's colors instead of telescope's hardcoded ones
    color_devicons = true,
  }
})

-- make telescope use gruvbox highlight groups
vim.cmd([[
  highlight TelescopeNormal guibg=#282828
  highlight TelescopePreviewNormal guibg=#1d2021
  highlight TelescopeBorder guifg=#504945 guibg=#282828
  highlight TelescopePreviewBorder guifg=#504945 guibg=#1d2021
  highlight TelescopePromptBorder guifg=#504945 guibg=#3c3836
  highlight TelescopePromptNormal guibg=#3c3836
  highlight TelescopeSelection guibg=#3c3836 guifg=#ebdbb2
  highlight TelescopeMatching guifg=#b8bb26
]])
EOF
