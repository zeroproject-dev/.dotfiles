require('rose-pine').setup({
  disable_background = false
})

require("catppuccin").setup({
  flavour = "mocha",
  no_italic = false,
  no_bold = false,
  styles = {
    comments = {"italic"},
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {"bold"},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {"bold"},
    operators = {},
  },
  integrations = {
    nvimtree = true,
    treesitter = true,
    telescope = true,
  }
})

-- Themes: catppuccin, rose-pine

function ColorMyPencils(color)

  color = color or "catppuccin"
  vim.cmd.colorscheme(color)

  --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
