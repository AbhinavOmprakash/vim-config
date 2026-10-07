-- Rocket Dark colorscheme for Neovim
-- Ported from the Atom Rocket Dark Syntax theme
-- Original theme by Nick Pfisterer

-- Clear previous highlights
vim.cmd("highlight clear")
if vim.g.syntax_on then
    vim.cmd("syntax reset")
end

-- Set colorscheme name
vim.g.colors_name = "rocket_dark"

-- Color palette based on styles/palette.less
local palette = {
    -- Monochrome
    mono_1 = "#d4bd93", -- Default text (hsl(37, 63%, 83%))
    mono_2 = "#8c7b63", -- (hsl(37, 20%, 55%))
    mono_3 = "#655c4d", -- (hsl(37, 15%, 40%))
    
    -- Hues
    hue_1  = "#73c7a5", -- Teal (hsl(163, 40%, 70%))
    hue_2  = "#7ba6cb", -- Blue (hsl(207, 47%, 65%))
    hue_3  = "#b493c5", -- Purple (hsl(274, 36%, 70%))
    hue_4  = "#ffce68", -- Yellow (hsl(39, 100%, 70%))
    hue_5  = "#de5546", -- Red 1 (hsl(11, 71%, 60%))
    hue_5_2 = "#c12a1a", -- Red 2 (hsl(11, 71%, 50%))
    hue_6  = "#e7803e", -- Orange 1 (hsl(23, 81%, 60%))
    hue_6_2 = "#db5f12", -- Orange 2 (hsl(23, 81%, 50%))
    
    -- Syntax
    syntax_bg = "#332f2b", -- (hsl(11, 2%, 20%))
    syntax_gutter = "#4a3f30", -- Darkened mono_2
    syntax_guide = "#3a362f", -- Approximation of 15% of mono_1
    syntax_accent = "#d4bd93",
    syntax_cursor_line = "#3a3630", -- Approximation of 4% of hue_4
    
    -- From syntax-variables.less
    syntax_selection = "#443a34", -- 10% lighter than bg
    syntax_selection_flash = "#d4bd93",
    syntax_result_marker = "#5a5046", -- Approximation of 24% of accent
    syntax_result_marker_selected = "#d4bd93",
    syntax_gutter_bg_selected = "#3e3933", -- 8% lighter than bg
    syntax_invisible_char = "#3a362f", -- Approximation of 15% of fg
    
    -- Git colors
    syntax_color_renamed = "#3c9df8", -- hsl(208, 100%, 60%)
    syntax_color_added = "#42d692", -- hsl(150, 60%, 54%)
    syntax_color_modified = "#e6b34c", -- hsl(40, 60%, 70%)
    syntax_color_removed = "#f55742", -- hsl(0, 70%, 60%)
    
    -- Derived colors
    syntax_deprecated_fg = "#735026", -- Darkened modified
    syntax_deprecated_bg = "#e6b34c",
    syntax_illegal_fg = "#ffffff", -- white
    syntax_illegal_bg = "#f55742",
}

-- Setup terminal colors
local term_colors = {
    ["terminal_color_0"] = palette.mono_3,
    ["terminal_color_1"] = palette.hue_5,
    ["terminal_color_2"] = palette.hue_4,
    ["terminal_color_3"] = palette.hue_6,
    ["terminal_color_4"] = palette.hue_2,
    ["terminal_color_5"] = palette.hue_3,
    ["terminal_color_6"] = palette.hue_1,
    ["terminal_color_7"] = palette.mono_1,
    ["terminal_color_8"] = palette.mono_3,
    ["terminal_color_9"] = palette.hue_5,
    ["terminal_color_10"] = palette.hue_4,
    ["terminal_color_11"] = palette.hue_6,
    ["terminal_color_12"] = palette.hue_2,
    ["terminal_color_13"] = palette.hue_3,
    ["terminal_color_14"] = palette.hue_1,
    ["terminal_color_15"] = palette.mono_1,
}

for term_color, hex in pairs(term_colors) do
    vim.g[term_color] = hex
end

-- Define highlight groups
local highlights = {
    -- Neovim specific
    Normal = { fg = palette.mono_1, bg = palette.syntax_bg },
    NormalFloat = { fg = palette.mono_1, bg = palette.syntax_bg },
    NormalNC = { fg = palette.mono_1, bg = palette.syntax_bg },
    LineNr = { fg = palette.syntax_gutter },
    CursorLineNr = { fg = palette.mono_1, bg = palette.syntax_gutter_bg_selected },
    SignColumn = { fg = palette.mono_1, bg = palette.syntax_bg },
    FoldColumn = { fg = palette.mono_3 },
    VertSplit = { fg = palette.syntax_guide },
    Folded = { fg = palette.mono_2, bg = palette.syntax_gutter_bg_selected },
    EndOfBuffer = { fg = palette.syntax_gutter },
    ColorColumn = { bg = palette.syntax_cursor_line },
    Conceal = { fg = palette.mono_3 },
    Cursor = { fg = palette.syntax_bg, bg = palette.syntax_accent },
    CursorIM = { fg = palette.syntax_bg, bg = palette.syntax_accent },
    CursorLine = { bg = palette.syntax_cursor_line },
    CursorColumn = { bg = palette.syntax_cursor_line },
    Directory = { fg = palette.hue_2 },
    ErrorMsg = { fg = palette.hue_5 },
    WarningMsg = { fg = palette.hue_6 },
    MoreMsg = { fg = palette.hue_2 },
    IncSearch = { fg = palette.syntax_bg, bg = palette.hue_6 },
    Search = { fg = palette.syntax_bg, bg = palette.hue_6 },
    MatchParen = { bg = palette.syntax_cursor_line, underline = true },
    NonText = { fg = palette.syntax_invisible_char },
    Whitespace = { fg = palette.syntax_invisible_char },
    SpecialKey = { fg = palette.syntax_invisible_char },
    Pmenu = { fg = palette.mono_1, bg = palette.syntax_selection },
    PmenuSel = { fg = palette.mono_1, bg = palette.syntax_selection, reverse = true },
    PmenuSbar = { bg = palette.syntax_selection },
    PmenuThumb = { bg = palette.mono_1 },
    Question = { fg = palette.hue_2 },
    SpellBad = { fg = palette.hue_5, undercurl = true },
    SpellCap = { fg = palette.hue_6, undercurl = true },
    SpellRare = { fg = palette.hue_3, undercurl = true },
    SpellLocal = { fg = palette.hue_2, undercurl = true },
    StatusLine = { fg = palette.mono_1, bg = palette.syntax_selection },
    StatusLineNC = { fg = palette.mono_3, bg = palette.syntax_selection },
    TabLine = { fg = palette.mono_2, bg = palette.syntax_selection },
    TabLineFill = { fg = palette.mono_3, bg = palette.syntax_selection },
    TabLineSel = { fg = palette.mono_1, bg = palette.syntax_bg },
    Title = { fg = palette.mono_1 },
    Visual = { bg = palette.syntax_selection },
    VisualNOS = { bg = palette.syntax_selection },
    WildMenu = { fg = palette.mono_1, bg = palette.syntax_selection },
    
    -- Diagnostics
    DiagnosticError = { fg = palette.hue_5 },
    DiagnosticWarn = { fg = palette.hue_6 },
    DiagnosticInfo = { fg = palette.hue_2 },
    DiagnosticHint = { fg = palette.hue_3 },
    DiagnosticUnderlineError = { sp = palette.hue_5, undercurl = true },
    DiagnosticUnderlineWarn = { sp = palette.hue_6, undercurl = true },
    DiagnosticUnderlineInfo = { sp = palette.hue_2, undercurl = true },
    DiagnosticUnderlineHint = { sp = palette.hue_3, undercurl = true },
    
    -- Standard syntax groups
    Comment = { fg = palette.mono_3 },
    Constant = { fg = palette.hue_6 },
    String = { fg = palette.hue_4 },
    Character = { fg = palette.hue_4 },
    Number = { fg = palette.hue_6 },
    Boolean = { fg = palette.hue_6 },
    Float = { fg = palette.hue_6 },
    
    Identifier = { fg = palette.hue_5 },
    Function = { fg = palette.hue_2 },
    
    Statement = { fg = palette.hue_3 },
    Conditional = { fg = palette.hue_3 },
    Repeat = { fg = palette.hue_3 },
    Label = { fg = palette.hue_3 },
    Operator = { fg = palette.mono_1 },
    Keyword = { fg = palette.hue_3 },
    Exception = { fg = palette.hue_3 },
    
    PreProc = { fg = palette.hue_3 },
    Include = { fg = palette.hue_3 },
    Define = { fg = palette.hue_3 },
    Macro = { fg = palette.hue_3 },
    PreCondit = { fg = palette.hue_3 },
    
    Type = { fg = palette.hue_6_2 },
    StorageClass = { fg = palette.hue_3 },
    Structure = { fg = palette.hue_3 },
    Typedef = { fg = palette.hue_3 },
    
    Special = { fg = palette.hue_1 },
    SpecialChar = { fg = palette.hue_1 },
    Tag = { fg = palette.hue_5 },
    Delimiter = { fg = palette.mono_1 },
    SpecialComment = { fg = palette.mono_3 },
    Debug = { fg = palette.hue_5_2 },
    
    Underlined = { underline = true },
    Ignore = { fg = palette.mono_3 },
    Error = { fg = palette.syntax_illegal_fg, bg = palette.syntax_illegal_bg },
    Todo = { fg = palette.hue_6, bg = palette.syntax_bg },
    
    -- Treesitter syntax groups
    ["@comment"] = { link = "Comment" },
    ["@error"] = { link = "Error" },
    ["@none"] = { fg = palette.mono_1 },
    ["@preproc"] = { link = "PreProc" },
    ["@define"] = { link = "Define" },
    ["@operator"] = { link = "Operator" },
    
    ["@punctuation.delimiter"] = { link = "Delimiter" },
    ["@punctuation.bracket"] = { fg = palette.mono_1 },
    ["@punctuation.special"] = { fg = palette.mono_1 },
    
    ["@string"] = { link = "String" },
    ["@string.regex"] = { fg = palette.hue_1 },
    ["@string.escape"] = { fg = palette.hue_1 },
    ["@string.special"] = { fg = palette.hue_1 },
    
    ["@character"] = { link = "Character" },
    ["@character.special"] = { fg = palette.hue_1 },
    
    ["@boolean"] = { link = "Boolean" },
    ["@number"] = { link = "Number" },
    ["@float"] = { link = "Float" },
    
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { fg = palette.hue_1 },
    ["@function.call"] = { link = "Function" },
    ["@function.macro"] = { fg = palette.hue_2 },
    
    ["@method"] = { fg = palette.hue_2 },
    ["@method.call"] = { fg = palette.hue_2 },
    
    ["@constructor"] = { fg = palette.hue_6_2 },
    ["@parameter"] = { fg = palette.mono_1 },
    
    ["@keyword"] = { link = "Keyword" },
    ["@keyword.function"] = { fg = palette.hue_3 },
    ["@keyword.operator"] = { fg = palette.hue_3 },
    ["@keyword.return"] = { fg = palette.hue_3 },
    
    ["@conditional"] = { link = "Conditional" },
    ["@repeat"] = { link = "Repeat" },
    ["@label"] = { link = "Label" },
    ["@include"] = { link = "Include" },
    ["@exception"] = { link = "Exception" },
    
    ["@type"] = { link = "Type" },
    ["@type.builtin"] = { fg = palette.hue_6_2 },
    ["@type.definition"] = { fg = palette.hue_6_2 },
    ["@type.qualifier"] = { fg = palette.hue_3 },
    
    ["@storageclass"] = { link = "StorageClass" },
    ["@attribute"] = { fg = palette.hue_6 },
    ["@field"] = { fg = palette.hue_5 },
    ["@property"] = { fg = palette.mono_1 },
    
    ["@variable"] = { fg = palette.hue_5 },
    ["@variable.builtin"] = { fg = palette.hue_5_2 },
    
    ["@constant"] = { link = "Constant" },
    ["@constant.builtin"] = { fg = palette.hue_6 },
    ["@constant.macro"] = { fg = palette.hue_6 },
    
    ["@namespace"] = { fg = palette.hue_6_2 },
    ["@symbol"] = { fg = palette.hue_1 },
    
    ["@text"] = { fg = palette.mono_1 },
    ["@text.strong"] = { fg = palette.hue_6 },
    ["@text.emphasis"] = { fg = palette.hue_3 },
    ["@text.underline"] = { underline = true },
    ["@text.strike"] = { strikethrough = true },
    ["@text.title"] = { fg = palette.hue_5 },
    ["@text.literal"] = { fg = palette.hue_4 },
    ["@text.uri"] = { fg = palette.hue_1, underline = true },
    ["@text.math"] = { fg = palette.hue_4 },
    ["@text.reference"] = { fg = palette.hue_1 },
    ["@text.environment"] = { fg = palette.hue_6_2 },
    ["@text.environment.name"] = { fg = palette.hue_6 },
    
    ["@text.diff.add"] = { fg = palette.syntax_color_added },
    ["@text.diff.delete"] = { fg = palette.syntax_color_removed },
    
    ["@tag"] = { fg = palette.hue_5 },
    ["@tag.attribute"] = { fg = palette.hue_6 },
    ["@tag.delimiter"] = { fg = palette.mono_1 },
    
    -- Specific language customizations (from original theme)
    -- JavaScript
    javascriptOperator = { fg = palette.hue_3 },
    
    -- CSS
    cssSelectorOp = { fg = palette.mono_1 },
    cssAttributeSelector = { fg = palette.hue_6 },
    cssDefinition = { fg = palette.hue_3 },
    
    -- HTML
    htmlTagName = { fg = palette.hue_5 },
    htmlArg = { fg = palette.hue_6 },
    
    -- Ruby
    rubySymbol = { fg = palette.hue_1 },
    rubyBlockParameter = { fg = palette.hue_5 },
    rubyClassName = { fg = palette.hue_6_2 },
    
    -- Python
    pythonOperator = { fg = palette.hue_3 },
    pythonParam = { fg = palette.hue_6 },
    
    -- Git diff
    DiffAdd = { fg = palette.syntax_color_added },
    DiffChange = { fg = palette.syntax_color_modified },
    DiffDelete = { fg = palette.syntax_color_removed },
    DiffText = { fg = palette.syntax_color_modified },
    
    -- Git gutter
    GitGutterAdd = { fg = palette.syntax_color_added },
    GitGutterChange = { fg = palette.syntax_color_modified },
    GitGutterDelete = { fg = palette.syntax_color_removed },
    
    -- LSP
    LspReferenceText = { bg = palette.syntax_selection },
    LspReferenceRead = { bg = palette.syntax_selection },
    LspReferenceWrite = { bg = palette.syntax_selection },
    LspSignatureActiveParameter = { fg = palette.hue_6 },
}

-- Apply highlights
for group, styles in pairs(highlights) do
    if styles.link then
        -- Handle linked groups
        vim.api.nvim_set_hl(0, group, { link = styles.link })
    else
        -- Handle direct styling
        local hl_args = {}
        
        -- Add colors
        if styles.fg then hl_args.fg = styles.fg end
        if styles.bg then hl_args.bg = styles.bg end
        if styles.sp then hl_args.sp = styles.sp end
        
        -- Add style attributes (no italic or bold)
        if styles.underline then hl_args.underline = true end
        if styles.undercurl then hl_args.undercurl = true end
        if styles.reverse then hl_args.reverse = true end
        if styles.inverse then hl_args.inverse = true end
        if styles.strikethrough then hl_args.strikethrough = true end
        
        -- Use Neovim's API to set highlights
        vim.api.nvim_set_hl(0, group, hl_args)
    end
end

-- Return the colorscheme for lazy loading
return {
    colors = palette
}
