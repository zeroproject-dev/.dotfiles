return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = {},
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "V13Axel/neotest-pest" },
    opts = { adapters = { "neotest-pest" } },
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, {
  --       "blade",
  --       "php_only",
  --     })
  --   end,
  --   config = function(_, opts)
  --     vim.filetype.add({
  --       pattern = {
  --         [".*%.blade%.php"] = "blade",
  --       },
  --     })
  --
  --     require("nvim-treesitter.configs").setup(opts)
  --     local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  --     parser_config["blade"] = {
  --       install_info = {
  --         url = "https://github.com/EmranMR/tree-sitter-blade",
  --         files = { "src/parser.c" },
  --         branch = "main",
  --       },
  --       filetype = "blade",
  --     }
  --   end,
  -- },
  -- {
  --   "ricardoramirezr/blade-nav.nvim",
  --   dependencies = {
  --     "hrsh7th/nvim-cmp",
  --   },
  --   ft = { "blade", "php" },
  -- },
}
