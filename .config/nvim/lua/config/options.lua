-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- vim.opt.tabstop = 2
-- vim.opt.shiftwidth = 2
-- vim.opt.expandtab = true
-- vim.bo.softtabstop = 2

vim.opt.wrap = true
vim.opt.scrolloff = 5

local function my_paste(_)
  return function(_)
    local content = vim.fn.getreg('"')
    return vim.split(content, "\n")
  end
end

if os.getenv("SSH_TTY") == nil then
  vim.opt.clipboard:append("unnamedplus")
else
  vim.opt.clipboard:append("unnamedplus")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = my_paste("+"),
      ["*"] = my_paste("*"),
    },
  }
end
