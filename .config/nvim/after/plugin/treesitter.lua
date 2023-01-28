local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then return end

ts.setup {
  ensure_installed = {
    "help",
    "bash",
    "cmake",
    "make",
    "gitignore",
    "javascript",
    "typescript",
    "json",
    "css",
    "html",
    "c",
    "cpp",
    "lua",
    "rust",
    "tsx",
    "python",
  },

  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {},
  },
  autotag = {
    enable = true,
  },
}
