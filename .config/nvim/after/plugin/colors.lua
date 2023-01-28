local status_r, rose_pine = pcall(require, "rose-pine")
if not status_r then return end

local status_c, catppuccin = pcall(require, "catppuccin")
if not status_c then return end

local status_n, neosolarized = pcall(require, "neosolarized")
if not status_n then return end

rose_pine.setup({
  disable_background = false
})

catppuccin.setup({
  flavour = "mocha",
  no_italic = false,
  no_bold = false,
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = { "bold" },
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = { "bold" },
    operators = {},
  },
  integrations = {
    nvimtree = true,
    treesitter = true,
    telescope = true,
  }
})

neosolarized.setup({ comment_italics = true })

function SetTheme(color)

  color = color or "catppuccin"
  vim.cmd.colorscheme(color)

  if color == "neosolarized" then
    local colorbuddy = require('colorbuddy.init')
    local Color = colorbuddy.Color
    local colors = colorbuddy.colors
    local Group = colorbuddy.Group
    local groups = colorbuddy.groups
    local styles = colorbuddy.styles

    Color.new('black', '#000000')
    Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
    Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
    Group.new('Visual', colors.none, colors.base03, styles.reverse)

    local cError = groups.Error.fg
    local cInfo = groups.Information.fg
    local cWarn = groups.Warning.fg
    local cHint = groups.Hint.fg

    Group.new('DiagnosticVirtualTextError', cError, cError:dark():dark():dark():dark(), styles.NONE)
    Group.new('DiagnosticVirtualTextInfo', cInfo, cInfo:dark():dark():dark(), styles.NONE)
    Group.new('DiagnosticVirtualTextWarn', cWarn, cWarn:dark():dark():dark(), styles.NONE)
    Group.new('DiagnosticVirtualTextHint', cHint, cHint:dark():dark():dark(), styles.NONE)
    Group.new('DiagnosticUnderlineError', colors.none, colors.none, styles.undercurl, cError)
    Group.new('DiagnosticUnderlineWarn', colors.none, colors.none, styles.undercurl, cWarn)
    Group.new('DiagnosticUnderlineInfo', colors.none, colors.none, styles.undercurl, cInfo)
    Group.new('DiagnosticUnderlineHint', colors.none, colors.none, styles.undercurl, cHint)
  end

  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetTheme()
