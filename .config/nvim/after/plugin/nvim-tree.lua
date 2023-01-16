vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

-- require("nvim-tree").setup()

-- OR setup with some options
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require("nvim-tree").setup({
  -- sort_by = "case_sensitive",
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = {"l", "<CR>", "o"}, cb = tree_cb "edit" },
        { key = {"h"}, cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
