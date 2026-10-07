-- pastel_sunset.lua
-- A sunset-inspired theme for Neovim
-- Save this as ~/.config/nvim/colors/pastel_sunset.lua

-- Clear existing highlighting and set the colors
vim.cmd("highlight clear")
if vim.g.syntax_on then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "pastel_sunset"

-- Define sunset-inspired color palette
local colors = {
    bg = "#282828",       -- Dark background
    bg_lighter = "#2a252e", -- Slightly lighter background for UI elements
    fg = "#ebe9ed",       -- Light foreground text
    
    -- Primary sunset palette
    coral = "#ff875c",    -- Warm coral (sunset orange)
    melon = "#ffb499",    -- Lighter coral/peach
    robin_egg_blue = "#4ecdc4", -- Teal blue
    columbia_blue = "#b4d3e4", -- Light sky blue
    wisteria = "#d1afe9", -- Soft purple
    bittersweet = "#e9695d", -- Reddish orange (for errors)
    moss_green = "#8f9779", -- Muted green
    ash_grey = "#a8ae98", -- Light sage green
    
    -- UI specific colors
    selection = "#352e3d", -- Subtle selection background
    line_nr = "#605766",   -- Muted purple-grey for line numbers
    cursor = "#ff875c",    -- Cursor uses coral for visibility
}

-- Define all highlight groups
local highlights = {
    -- UI elements
    Normal = { fg = colors.fg, bg = colors.bg },
    NormalFloat = { fg = colors.fg, bg = colors.bg_lighter },
    LineNr = { fg = colors.line_nr },
    SignColumn = { bg = colors.bg },
    Cursor = { fg = colors.bg, bg = colors.cursor },
    CursorLine = { bg = colors.bg_lighter },
    CursorLineNr = { fg = colors.coral, bold = true },
    ColorColumn = { bg = colors.bg_lighter },
    Folded = { fg = colors.columbia_blue, bg = colors.bg_lighter },
    FoldColumn = { fg = colors.line_nr, bg = colors.bg },
    VertSplit = { fg = colors.line_nr, bg = colors.bg },
    TabLine = { fg = colors.line_nr, bg = colors.bg },
    TabLineFill = { fg = colors.line_nr, bg = colors.bg },
    TabLineSel = { fg = colors.coral, bg = colors.bg_lighter },
    Title = { fg = colors.wisteria, bold = true },
    Visual = { bg = colors.selection },
    VisualNOS = { bg = colors.selection },
    Search = { fg = colors.bg, bg = colors.melon },
    IncSearch = { fg = colors.bg, bg = colors.coral },
    Pmenu = { fg = colors.fg, bg = colors.bg_lighter },
    PmenuSel = { fg = colors.bg, bg = colors.coral },
    PmenuSbar = { bg = colors.bg_lighter },
    PmenuThumb = { bg = colors.line_nr },
    StatusLine = { fg = colors.fg, bg = colors.bg_lighter },
    StatusLineNC = { fg = colors.line_nr, bg = colors.bg },
    WildMenu = { fg = colors.bg, bg = colors.coral },
    MatchParen = { fg = colors.coral, bold = true },
    ModeMsg = { fg = colors.ash_grey },
    MoreMsg = { fg = colors.moss_green },
    Question = { fg = colors.moss_green },
    WarningMsg = { fg = colors.melon },
    ErrorMsg = { fg = colors.bittersweet },
    Directory = { fg = colors.columbia_blue },
    NonText = { fg = colors.line_nr },
    SpecialKey = { fg = colors.line_nr },
    Conceal = { fg = colors.wisteria, bg = colors.bg },
    SpellBad = { fg = colors.bittersweet, undercurl = true },
    SpellCap = { fg = colors.robin_egg_blue, undercurl = true },
    SpellRare = { fg = colors.wisteria, undercurl = true },
    SpellLocal = { fg = colors.ash_grey, undercurl = true },
    
    -- Syntax highlighting
    Comment = { fg = colors.ash_grey, italic = true },
    Constant = { fg = colors.coral },
    String = { fg = colors.moss_green },
    Character = { fg = colors.moss_green },
    Number = { fg = colors.melon },
    Boolean = { fg = colors.coral },
    Float = { fg = colors.melon },
    Identifier = { fg = colors.wisteria },
    Function = { fg = colors.robin_egg_blue },
    Statement = { fg = colors.coral },
    Conditional = { fg = colors.coral },
    Repeat = { fg = colors.coral },
    Label = { fg = colors.melon },
    Operator = { fg = colors.columbia_blue },
    Keyword = { fg = colors.coral },
    Exception = { fg = colors.bittersweet },
    PreProc = { fg = colors.columbia_blue },
    Include = { fg = colors.robin_egg_blue },
    Define = { fg = colors.robin_egg_blue },
    Macro = { fg = colors.robin_egg_blue },
    PreCondit = { fg = colors.columbia_blue },
    Type = { fg = colors.robin_egg_blue },
    StorageClass = { fg = colors.wisteria },
    Structure = { fg = colors.wisteria },
    Typedef = { fg = colors.wisteria },
    Special = { fg = colors.melon },
    SpecialChar = { fg = colors.melon },
    Tag = { fg = colors.coral },
    Delimiter = { fg = colors.fg },
    SpecialComment = { fg = colors.ash_grey, italic = true },
    Debug = { fg = colors.bittersweet },
    Underlined = { underline = true },
    Error = { fg = colors.bittersweet },
    Todo = { fg = colors.robin_egg_blue, bold = true },
    
    -- Git
    DiffAdd = { fg = colors.moss_green, bg = colors.bg },
    DiffChange = { fg = colors.columbia_blue, bg = colors.bg },
    DiffDelete = { fg = colors.bittersweet, bg = colors.bg },
    DiffText = { fg = colors.coral, bg = colors.bg },
    
    -- LSP
    DiagnosticError = { fg = colors.bittersweet },
    DiagnosticWarn = { fg = colors.melon },
    DiagnosticInfo = { fg = colors.columbia_blue },
    DiagnosticHint = { fg = colors.ash_grey },
    DiagnosticUnderlineError = { undercurl = true, sp = colors.bittersweet },
    DiagnosticUnderlineWarn = { undercurl = true, sp = colors.melon },
    DiagnosticUnderlineInfo = { undercurl = true, sp = colors.columbia_blue },
    DiagnosticUnderlineHint = { undercurl = true, sp = colors.ash_grey },
    
    -- Plugins
    -- NERDTree
    NERDTreeDir = { fg = colors.robin_egg_blue },
    NERDTreeDirSlash = { fg = colors.coral },
    NERDTreeOpenable = { fg = colors.melon },
    NERDTreeClosable = { fg = colors.melon },
    NERDTreeFile = { fg = colors.fg },
    NERDTreeExecFile = { fg = colors.moss_green },
    
    -- GitGutter
    GitGutterAdd = { fg = colors.moss_green },
    GitGutterChange = { fg = colors.columbia_blue },
    GitGutterDelete = { fg = colors.bittersweet },
    
    -- Coc
    CocErrorSign = { fg = colors.bittersweet },
    CocWarningSign = { fg = colors.melon },
    CocInfoSign = { fg = colors.columbia_blue },
    CocHintSign = { fg = colors.ash_grey },
    
    -- Telescope
    TelescopeNormal = { fg = colors.fg, bg = colors.bg_lighter },
    TelescopeBorder = { fg = colors.line_nr, bg = colors.bg_lighter },
    TelescopePromptBorder = { fg = colors.line_nr },
    TelescopeResultsBorder = { fg = colors.line_nr },
    TelescopePreviewBorder = { fg = colors.line_nr },
    TelescopeSelection = { fg = colors.fg, bg = colors.selection },
    TelescopeMatching = { fg = colors.coral, bold = true },
    
    -- Airline/statuslines
    airline_a = { fg = colors.bg, bg = colors.coral, bold = true },
    airline_b = { fg = colors.fg, bg = colors.bg_lighter },
    airline_c = { fg = colors.ash_grey, bg = colors.bg }
}

-- Apply highlight groups
for group, styles in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, styles)
end

-- Terminal colors
vim.g.terminal_color_0 = colors.bg
vim.g.terminal_color_1 = colors.bittersweet
vim.g.terminal_color_2 = colors.moss_green
vim.g.terminal_color_3 = colors.melon
vim.g.terminal_color_4 = colors.robin_egg_blue
vim.g.terminal_color_5 = colors.wisteria
vim.g.terminal_color_6 = colors.columbia_blue
vim.g.terminal_color_7 = colors.fg
vim.g.terminal_color_8 = colors.line_nr
vim.g.terminal_color_9 = colors.coral
vim.g.terminal_color_10 = colors.ash_grey
vim.g.terminal_color_11 = colors.melon
vim.g.terminal_color_12 = colors.columbia_blue
vim.g.terminal_color_13 = colors.wisteria
vim.g.terminal_color_14 = colors.robin_egg_blue
vim.g.terminal_color_15 = colors.fg
