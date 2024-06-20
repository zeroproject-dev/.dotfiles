return {
  "eckon/treesitter-current-functions",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-telescope/telescope.nvim" },
  keys = { "n", "<leader>fy", "<CMD>GetCurrentFunctions<CR>", desc = "List current functions of the file" },
}
