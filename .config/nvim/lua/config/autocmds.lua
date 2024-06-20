-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local make_files_commands = {
  { { "rust", "rs" }, "cargo build" },
  { { "c" }, "clang %:p:h/*.c -o %:t:r && ./%:t:r" },
  { { "java" }, "java %" },
  { { "cpp" }, "clang++ %:p:h/*.cpp -o %:t:r && ./%:t:r" },
  { { "javascript", "js" }, "node %" },
  { { "typescript", "ts" }, "npx tsx %" },
  { { "python" }, "python %" },
  { { "lua" }, "lua %" },
  { { "sh" }, "bash %" },
}

for _, v in ipairs(make_files_commands) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = v[1],
    callback = function()
      vim.opt_local.makeprg = v[2]
    end,
  })
end

-- function _G.set_terminal_keymaps()
--   local opts = { buffer = 0 }
--   vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
--   vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
--   vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
--   vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
--   vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
--   vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
-- end
--
-- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
