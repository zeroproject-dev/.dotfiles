vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Visual Block mode
vim.keymap.set("n", "<leader>v", "v<C-v>")

-- Move lines selected
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- vim.keymap.set("n", "J", "mzJ`z")

-- Page down and page up to scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- search next and previous results from a search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste last thing that you delete
vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy selected
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete selected
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- ctrl + c is like press Escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("n", "Q", "<nop>")

-- format document
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- change between buffers
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- replace that word where the cursor is
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- toggle nerdtree
vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { silent = true })

-- resize buffers
vim.keymap.set("n", "<A-h>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<A-j>", ":resize -2<CR>", { silent = true })
vim.keymap.set("n", "<A-k>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<A-l>", ":vertical resize +2<CR>", { silent = true })

-- move between buffers
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- save current buffer
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { silent = true })

-- increment decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
vim.keymap.set("n", "dw", 'vb"_d')

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- New tab
vim.keymap.set("n", "<C-t>", ":tabedit<CR>", { silent = true })

-- Split window
vim.keymap.set("n", "ss", ":split<Return><C-w>w", { silent = true })
vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w", { silent = true })

-- Move between tabs
vim.keymap.set("n", "<S-h>", ":tabprevious<CR>", { silent = true })
vim.keymap.set("n", "<S-l>", ":tabnext<CR>", { silent = true })

-- Close tab
vim.keymap.set("n", "<C-w>", ":tabclose<CR>", { silent = true })

-- Exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })

local has = function (name)
  return vim.fn.has(name) == 1
end

local is_win = has("win32") or has("win64")
local is_mac = has("mac") or has("macunix")
local is_linux = has("unix")

if is_mac or is_linux then
  vim.opt.clipboard:append { 'unnamedplus' }
end

if is_win then
  vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }
end













