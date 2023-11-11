return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  main = "config",
  opts = {
    close_if_last_window = true,
    filesystem = {
      bind_to_cwd = false,
      cwd_target = {
        sidebar = "none", -- tab. window
        current = "none",
      },
    },
    window = {
      position = "left",
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
