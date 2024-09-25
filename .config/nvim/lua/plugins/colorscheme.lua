return {
  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   name = "catppuccin",
  --   opts = {
  --     integrations = {
  --       alpha = true,
  --       cmp = true,
  --       gitsigns = true,
  --       illuminate = true,
  --       indent_blankline = { enabled = true },
  --       lsp_trouble = true,
  --       mason = true,
  --       mini = true,
  --       native_lsp = {
  --         enabled = true,
  --         underlines = {
  --           errors = { "undercurl" },
  --           hints = { "undercurl" },
  --           warnings = { "undercurl" },
  --           information = { "undercurl" },
  --         },
  --       },
  --       styles = {
  --         comments = { "italic" },
  --         keywords = { "italic" },
  --       },
  --       navic = { enabled = true, custom_bg = "lualine" },
  --       neotest = true,
  --       noice = true,
  --       notify = true,
  --       neotree = true,
  --       semantic_tokens = true,
  --       telescope = true,
  --       treesitter = true,
  --       which_key = true,
  --     },
  --   },
  -- },
  {
    "tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      commentStyle = { italic = true },
      keywordsStyle = { italic = true },
      transparent = false,
      theme = "dragon",
    },
  },
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "darker",
      code_style = {
        comments = "italic",
        keywords = "italic,bold",
      },
    },
  },
  -- { -- carbonfox
  --   "EdenEast/nightfox.nvim",
  --   opts = {
  --     options = {
  --       styles = {
  --         comments = "italic",
  --         keywords = "bold",
  --         types = "bold",
  --       },
  --     },
  --   },
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
