vim.cmd("autocmd!")

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true

vim.opt.guicursor = ""

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.shell = "zsh"
vim.opt.backupskip = "/tmp/*,/private/tmp/*"
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.breakindent = true

vim.opt.backspace = "indent,eol,start"
-- vim.opt.path:append { "**" } -- for finding files in subdirectories or into subfolders
vim.opt.wildignore:append { "*/node_modules/*", "*/.git/*", "*/.cache/*", "*/.vscode/*", "*/.idea/*" }

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
-- not work on iterm2

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { "r" }

vim.opt.nu = true
vim.opt.relativenumber = true

local TAB_SIZE=2

vim.opt.tabstop = TAB_SIZE
vim.opt.softtabstop = TAB_SIZE
vim.opt.shiftwidth = TAB_SIZE
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = true
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 10
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 10
vim.opt.background = "dark"
























