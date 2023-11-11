return {
  "alexghergh/nvim-tmux-navigation",
  keys = {
    {
      "<C-h>",
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateLeft()
      end,
      mode = { "n", "v", "t" },
    },
    {
      "<C-j>",
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateDown()
      end,
      mode = { "n", "v", "t" },
    },
    {
      "<C-k>",
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateUp()
      end,
      mode = { "n", "v", "t" },
    },
    {
      "<C-l>",
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateRight()
      end,
      mode = { "n", "v", "t" },
    },
  },
  opts = {},
}
