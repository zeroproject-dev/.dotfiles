return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "jay-babu/mason-nvim-dap.nvim" },
  opts = function()
    require("dapui").setup()
    require("mason-nvim-dap").setup()
  end,
}
