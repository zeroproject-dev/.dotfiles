-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

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

vim.g.rustaceanvim = {
  server = {
    cmd = function()
      local mason_registry = require("mason-registry")
      local ra_binary = mason_registry.is_installed("rust-analyzer")
          -- This may need to be tweaked, depending on the operating system.
          and mason_registry.get_package("rust-analyzer"):get_install_path() .. "/rust-analyzer"
        or "rust-analyzer"
      return { ra_binary } -- You can add args to the list, such as '--log-file'
    end,
  },
}

function go_to_column_in_file(file_info_string)
  local file_info = vim.split(file_info_string, ":")
  local column = 0

  -- Abre el archivo
  vim.cmd("edit " .. file_info[1])

  -- Si hay más de dos elementos, establece la columna
  if #file_info > 2 then
    column = file_info[3]
    vim.cmd("normal! " .. column .. "|")
  end
end

vim.api.nvim_set_keymap(
  "n",
  "gff",
  ':lua go_to_column_in_file(vim.fn.expand("<cWORD>"))<CR>',
  { noremap = true, silent = true }
)

vim.g.lazyvim_php_lsp = "intelephense"
