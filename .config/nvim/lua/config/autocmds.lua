-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local make_files_commands = {
  { { "rust", "rs" }, { "cargo", "build" } },
  { { "c" }, { "clang", "%:p:h/*.c", "-o", "%:t:r", "&&", "./%:t:r" } },
  { { "java" }, { "java", "%" } },
  { { "cpp" }, { "clang++", "%:p:h/*.cpp", "-o", "%:t:r", "&&", "./%:t:r" } },
  { { "javascript", "js" }, { "node", "%" } },
  { { "typescript", "ts" }, { "npx", "tsx", "%" } },
  { { "python" }, { "python", "%" } },
  { { "lua" }, { "lua", "%" } },
  { { "sh" }, { "bash", "%" } },
}

local output_bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_name(output_bufnr, "Output Buffer")
vim.bo[output_bufnr].bufhidden = "hide"

local current_job_id = nil

for _, v in ipairs(make_files_commands) do
  for _, pattern in ipairs(v[1]) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = pattern,
      callback = function()
        local command = vim.fn.expandcmd(table.concat(v[2], " "))
        vim.api.nvim_buf_set_keymap(0, "n", "<leader><Enter>", "", {
          callback = function()
            vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "output:" })

            local append_data = function(_, data)
              if data then
                for _, line in ipairs(data) do
                  vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, { line })
                end
              end
            end

            current_job_id = vim.fn.jobstart(command, {
              stdout_buffered = false,
              on_stdout = append_data,
              on_stderr = append_data,
              on_exit = function()
                current_job_id = nil
              end,
            })

            vim.api.nvim_create_autocmd("BufWinLeave", {
              buffer = output_bufnr,
              once = true,
              callback = function()
                if current_job_id then
                  vim.fn.jobstop(current_job_id)
                  vim.api.nvim_out_write("Process stopped\n")
                  current_job_id = nil
                end
              end,
            })

            vim.cmd("vsplit")
            vim.cmd("buffer " .. output_bufnr)
          end,
          noremap = true,
          silent = true,
          desc = "Run make command",
        })
      end,
    })
  end
end

-- local make_files_commands = {
--   { { "rust", "rs" }, "cargo build" },
--   { { "c" }, "clang %:p:h/*.c -o %:t:r && ./%:t:r" },
--   { { "java" }, "java %" },
--   { { "cpp" }, "clang++ %:p:h/*.cpp -o %:t:r && ./%:t:r" },
--   { { "javascript", "js" }, "node %" },
--   { { "typescript", "ts" }, "npx tsx %" },
--   { { "python" }, "python %" },
--   { { "lua" }, "lua %" },
--   { { "sh" }, "bash %" },
-- }
--
-- for _, v in ipairs(make_files_commands) do
--   vim.api.nvim_create_autocmd("FileType", {
--     pattern = v[1],
--     callback = function()
--       vim.opt_local.makeprg = v[2]
--     end,
--   })
-- end
--
-- local output_bufnr, command = 69, { "clang", "main.c", "-o", "main", "&&", "./main" }
--
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = vim.api.nvim_create_augroup("autorun", { clear = true }),
--   pattern = "c",
--   callback = function()
--     local append_data = function(_, data)
--       if data then
--         vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
--       end
--     end
--
--     vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "output:" })
--     vim.fn.jobstart(command, {
--       stdout_buffered = true,
--       on_stdout = append_data,
--       on_stderr = append_data,
--     })
--   end,
-- })

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
