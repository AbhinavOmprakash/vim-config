-- pastel_sunset.lua
-- A minimal theme skeleton for Neovim
-- Save this as ~/.config/nvim/colors/pastel_sunset.lua

-- Clear existing highlighting and set the colors
vim.cmd("highlight clear")
if vim.g.syntax_on then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "pastel_sunset"

-- Define only background and foreground colors
local colors = {
    bg = "#1f1b22", -- Dark background
    fg = "#ebe9ed",   -- Warm off-white foreground
    coral = "#ff875c", 
    melon = "#ffb499",  -- lighter shade of coral, should be used thematically for things coral is used for
    robin_egg_blue = "#4ecdc4", 
    columbia_blue = "#b4d3e4", -- shade of robin_egg_blue, might be used in conjunction with it?
    wisteria = "#d1afe9",  -- nice accent color
    bittersweet ="#e9695d", -- could be used for errors
    moss_green = "#8f9779", 
    ash_grey ="#a8ae98" -- lighter shade of moss_green
}

-- Define all highlight groups to use the same foreground color
local highlights = {
    -- UI elements
    Normal = { fg = colors.fg, bg = colors.bg },
    NormalFloat = { fg = colors.fg, bg = colors.bg },
    LineNr = { fg = colors.fg },
    SignColumn = { fg = colors.fg, bg = colors.bg },
    Cursor = { fg = colors.bg, bg = colors.fg },
    CursorLine = { bg = colors.bg },
    CursorLineNr = { fg = colors.fg },
    ColorColumn = { bg = colors.bg },
    Folded = { fg = colors.fg, bg = colors.bg },
    FoldColumn = { fg = colors.fg, bg = colors.bg },
    VertSplit = { fg = colors.fg, bg = colors.bg },
    TabLine = { fg = colors.fg, bg = colors.bg },
    TabLineFill = { fg = colors.fg, bg = colors.bg },
    TabLineSel = { fg = colors.fg, bg = colors.bg },
    Title = { fg = colors.fg },
    Visual = { fg = colors.fg, bg = colors.bg },
    VisualNOS = { fg = colors.fg, bg = colors.bg },
    Search = { fg = colors.fg, bg = colors.bg },
    IncSearch = { fg = colors.fg, bg = colors.bg },
    Pmenu = { fg = colors.fg, bg = colors.bg },
    PmenuSel = { fg = colors.fg, bg = colors.bg },
    PmenuSbar = { bg = colors.bg },
    PmenuThumb = { bg = colors.bg },
    StatusLine = { fg = colors.fg, bg = colors.bg },
    StatusLineNC = { fg = colors.fg, bg = colors.bg },
    WildMenu = { fg = colors.fg, bg = colors.bg },
    MatchParen = { fg = colors.fg, bg = colors.bg },
    ModeMsg = { fg = colors.fg },
    MoreMsg = { fg = colors.fg },
    Question = { fg = colors.fg },
    WarningMsg = { fg = colors.fg },
    ErrorMsg = { fg = colors.fg },
    Directory = { fg = colors.fg },
    NonText = { fg = colors.fg },
    SpecialKey = { fg = colors.fg },
    Conceal = { fg = colors.fg, bg = colors.bg },
    SpellBad = { fg = colors.fg, undercurl = true },
    SpellCap = { fg = colors.fg, undercurl = true },
    SpellRare = { fg = colors.fg, undercurl = true },
    SpellLocal = { fg = colors.fg, undercurl = true },
    
    -- Syntax highlighting
    Comment = { fg = colors.fg },
    Constant = { fg = colors.fg },
    String = { fg = colors.fg },
    Character = { fg = colors.fg },
    Number = { fg = colors.fg },
    Boolean = { fg = colors.fg },
    Float = { fg = colors.fg },
    Identifier = { fg = colors.fg },
    Function = { fg = colors.fg },
    Statement = { fg = colors.fg },
    Conditional = { fg = colors.fg },
    Repeat = { fg = colors.fg },
    Label = { fg = colors.fg },
    Operator = { fg = colors.fg },
    Keyword = { fg = colors.fg },
    Exception = { fg = colors.fg },
    PreProc = { fg = colors.fg },
    Include = { fg = colors.fg },
    Define = { fg = colors.fg },
    Macro = { fg = colors.fg },
    PreCondit = { fg = colors.fg },
    Type = { fg = colors.fg },
    StorageClass = { fg = colors.fg },
    Structure = { fg = colors.fg },
    Typedef = { fg = colors.fg },
    Special = { fg = colors.fg },
    SpecialChar = { fg = colors.fg },
    Tag = { fg = colors.fg },
    Delimiter = { fg = colors.fg },
    SpecialComment = { fg = colors.fg },
    Debug = { fg = colors.fg },
    Underlined = { fg = colors.fg, underline = true },
    Ignore = { fg = colors.fg },
    Error = { fg = colors.fg },
    Todo = { fg = colors.fg },
    
    -- Git
    DiffAdd = { fg = colors.fg, bg = colors.bg },
    DiffChange = { fg = colors.fg, bg = colors.bg },
    DiffDelete = { fg = colors.fg, bg = colors.bg },
    DiffText = { fg = colors.fg, bg = colors.bg },
    
    -- LSP
    DiagnosticError = { fg = colors.fg },
    DiagnosticWarn = { fg = colors.fg },
    DiagnosticInfo = { fg = colors.fg },
    DiagnosticHint = { fg = colors.fg },
    
    -- Plugins
    NERDTreeDir = { fg = colors.fg },
    NERDTreeDirSlash = { fg = colors.fg },
    NERDTreeOpenable = { fg = colors.fg },
    NERDTreeClosable = { fg = colors.fg },
    NERDTreeFile = { fg = colors.fg },
    NERDTreeExecFile = { fg = colors.fg },
    
    GitGutterAdd = { fg = colors.fg },
    GitGutterChange = { fg = colors.fg },
    GitGutterDelete = { fg = colors.fg },
    
    CocErrorSign = { fg = colors.fg },
    CocWarningSign = { fg = colors.fg },
    CocInfoSign = { fg = colors.fg },
    CocHintSign = { fg = colors.fg }
}

-- Apply highlight groups
for group, styles in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, styles)
end

-- Terminal colors
vim.g.terminal_color_0 = colors.bg
vim.g.terminal_color_7 = colors.fg
vim.g.terminal_color_8 = colors.fg
vim.g.terminal_color_15 = colors.fg
