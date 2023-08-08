return {
  "nvim-neo-tree/neo-tree.nvim",
  main = "config",
  opts = {
    window = {
      mappings = {
        ["l"] = "open",
        ["h"] = "open",
      },
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
