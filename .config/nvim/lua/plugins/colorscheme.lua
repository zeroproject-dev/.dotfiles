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
  -- {
  --   "tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     styles = {
  --       comments = { italic = true },
  --       keywords = { italic = true },
  --     },
  --   },
  -- },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     commentStyle = { italic = true },
  --     keywordsStyle = { italic = true },
  --     transparent = false,
  --     theme = "dragon",
  --   },
  -- },
  -- { -- no
  --   "navarasu/onedark.nvim",
  --   opts = {
  --     style = "darker",
  --     code_style = {
  --       comments = "italic",
  --       keywords = "italic,bold",
  --     },
  --   },
  -- },
  { -- carbonfox
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "bold",
        },
      },
    },
  },
  -- {
  --   "oxfist/night-owl.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function() end,
  -- },
  -- {
  --   "AlexvZyl/nordic.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function() end,
  -- },
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   priority = 1000, -- Ensure it loads first
  --   opts = {
  --     styles = {
  --       comments = "italic",
  --       keywords = "italic,bold",
  --       types = "italic,bold",
  --     },
  --   },
  -- },
  -- {
  --   "zenbones-theme/zenbones.nvim",
  --   -- Optionally install Lush. Allows for more configuration or extending the colorscheme
  --   -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
  --   -- In Vim, compat mode is turned on as Lush only works in Neovim.
  --   dependencies = "rktjmp/lush.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   -- you can set set configuration options here
  --   -- config = function()
  --   --     vim.g.zenbones_darken_comments = 45
  --   --     vim.cmd.colorscheme('zenbones')
  --   -- end
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "carbonfox",
    },
  },
}
