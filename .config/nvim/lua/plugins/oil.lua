return {
  "stevearc/oil.nvim",
  keys = {
    { "<leader>o", "<CMD>Oil --float<CR>", desc = "Oil Explorer" },
  },
  opts = {
    default_file_explorer = false,
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 5,
    },
  },
}
