-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ZenMode
vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Toggle ZenMode" })

-- Dap
vim.keymap.set("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle Dap Ui" })

vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint at line" })
vim.keymap.set("n", "<leader>dr", "<cmd>DapContinue<CR>", { desc = "Start or continue the debugger" })

-- remove <A-{j,k}> binding
vim.keymap.set({ "n", "i" }, "<A-j>", "<Nop>", { desc = "Move down" })
vim.keymap.set({ "n", "i" }, "<A-k>", "<Nop>", { desc = "Move up" })

-- run make and copen
vim.keymap.set("n", "<leader><CR>", ":make | :copen <CR>", { desc = "Run make (use :make and :copen)" })

-- Resize windows
vim.keymap.set("n", "<A-k>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<A-j>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<A-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<A-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- run rest.nvim
vim.keymap.set("n", "<A-r>", ":lua require('rest-nvim').run()<CR>", { desc = "Run rest.nvim" })

vim.keymap.set("n", "gf", ":GoToFile<cr>", nil)
vim.keymap.set("n", "gl", ":GoToFile<cr>", nil)

-- local function get_loc()
--   local elems = vim.fn.getqflist({
--     efm = vim.o.errorformat,
--     lines = { vim.api.nvim_get_current_line() },
--   }).items
--
--   print("Elements:", vim.fn.json_encode(elems))
--
--   if #elems < 1 then
--     return false
--   else
--     return true, elems[1].bufnr, elems[1].lnum, elems[1].col
--   end
-- end
--
-- local function jump(buffer, line, col)
--   vim.api.nvim_win_set_buf(0, buffer)
--   vim.api.nvim_win_set_cursor(0, { line, col })
-- end
--
-- vim.keymap.set("n", "gF", function()
--   local ok, bufr, line, col = get_loc()
--   -- local json_output = vim.fn.json_encode({ ok = ok, bufr = bufr, line = line, col = col })
--   -- print(json_output)
--   if ok then
--     jump(bufr, line, col)
--   end
-- end, { desc = "Jump to error location" })
