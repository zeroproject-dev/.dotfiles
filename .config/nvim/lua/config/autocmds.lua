-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local make_files_commands = {
  { { "rust", "rs" }, "cargo build" },
  { { "c" }, "clang %:p:h/*.c -o %:t:r && ./%:t:r" },
  { { "java" }, "java %" },
  { { "cpp" }, "clang++ %:p:h/*.cpp -o %:t:r && ./%:t:r" },
}

for _, v in ipairs(make_files_commands) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = v[1],
    callback = function()
      vim.opt_local.makeprg = v[2]
    end,
  })
end
