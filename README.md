# nvim config

Lua config on nvim 0.12, plugins managed by [lazy.nvim](https://github.com/folke/lazy.nvim).
Language servers and the debug adapter are installed by [mason](https://github.com/mason-org/mason.nvim).

```
init.lua                 entry point
lua/config/options.lua   editor options, env vars for clangd on macOS
lua/config/keymaps.lua   plugin-independent keymaps, clojure macros in registers
lua/config/autocmds.lua  autosave, per-filetype settings (c/cpp indent + folds, markdown, zig, sql)
lua/plugins/*.lua        one file per area, auto-imported by lazy.nvim
```

## Requirements outside nvim

Installed with Homebrew: `neovim fzf tree-sitter-cli clang-format cmake ninja cljfmt cljstyle pg_format black elm-format zig`.
Xcode command line tools (for `clang`, `lldb-dap` and the macOS SDK headers).

Mason installs these on first start (`:Mason` to inspect): `clangd clojure-lsp json-lsp neocmakelsp pyright lua-language-server gopls codelldb`.

## Keymaps

Local leader is `;`. Press `;` and wait to see all groups (which-key).

### LSP (any language)

| key | action |
|-----|--------|
| `;gd` `;gr` `;gi` `;gy` | definition / references (quickfix) / implementation / type definition |
| `;rn` `;ca` | rename / code action |
| `K` | hover |
| `[g` `]g` | prev / next diagnostic |
| `;ih` | toggle inlay hints |
| `;fo` | format buffer or selection (conform, falls back to the language server) |
| `<CR>` | accept completion, `<C-n>`/`<C-p>` move, `<C-space>` docs |

### C / C++

| key | action |
|-----|--------|
| `;gh` `;gH` | switch source/header (same window / vsplit) |
| `;cg` `;cb` `;cr` `;ct` | cmake generate / build / run / ctest |
| `;cc` `;cl` `;cy` | select build target / launch target / build type |
| `;cd` | debug the launch target |
| `;cq` `;cx` | show build output / stop build |
| `af` `if` `ac` `ic` `aa` `ia` | function / class / argument text objects |
| `]f` `[f` `]]` `[[` | next / prev function, next / prev class |
| `za` `zR` `zM` | folds (treesitter scopes) |

Build dir is `build/`. `compile_commands.json` is symlinked to the project root for clangd.

### Debugging (nvim-dap, codelldb)

| key | action |
|-----|--------|
| `;db` `;dB` | toggle breakpoint / conditional breakpoint |
| `;dc` or `F5` | start / continue. In a cmake project this picks the launch target. |
| `;ds` `;di` `;do` or `F10` `F11` `F12` | step over / into / out |
| `;de` `;dh` | eval expression (also visual) / hover value |
| `;dr` `;du` | toggle repl / toggle ui |
| `;dl` `;dx` | run last / terminate |

The UI opens when a session starts and closes when it ends. Also works for zig binaries.

### Find / files / git

| key | action |
|-----|--------|
| `;ff` `;fe` `;fb` `;fr` | files / live grep / buffers / resume last picker |
| `;fs` `;fS` `;fd` | document symbols / workspace symbols / diagnostics |
| `;fn` | find clojure namespace |
| `;fw` | flash jump |
| `;nn` `;nf` | file tree toggle / reveal current file |
| `;gg` | lazygit |
| `]c` `[c` `;hp` `;hs` `;hu` `;hr` `;hb` | git hunks: next / prev / preview / stage / unstage / reset / blame |
| `;ut` | undotree |
| `;af` `;ab` | arrow bookmarks (files / buffers) |
| `;dd` `;dw` | Dash.app lookup (filetype scoped / plain word) |

### Other

| key | action |
|-----|--------|
| `;zt` `;zb` | zig test / zig build (dispatch) |
| `;S` | sql: run query (dadbod-ui) |
| `]q` `[q` `;qq` `;qc` | quickfix next / prev / open / close |
| `gc` | comment (builtin) |
| `ys` `cs` `ds` | surround |
| `<C-n>` | multiple cursors (visual-multi) |
| `jk` | escape insert mode |

Clojure: conjure (`;ee`, `;er`, ...), vim-sexp, `:Clj` / `:Lein` to jack in. Registers `@s` `@n` `@e` `@t` hold the snitch macros.
