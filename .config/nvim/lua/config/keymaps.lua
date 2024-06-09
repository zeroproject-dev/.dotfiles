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

-- folds
-- vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "open all folds" })
-- vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "close all folds" })
