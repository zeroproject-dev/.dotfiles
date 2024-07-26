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
vim.bo[output_bufnr].buftype = "nofile"
vim.api.nvim_buf_set_keymap(output_bufnr, "n", "q", ":q<CR>", { noremap = true, silent = true })

local current_job_id = nil

local kill_current_job = function()
  if current_job_id then
    vim.fn.jobstop(current_job_id)
    current_job_id = nil
  end
end

for _, v in ipairs(make_files_commands) do
  for _, pattern in ipairs(v[1]) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = pattern,
      callback = function()
        local command = vim.fn.expandcmd(table.concat(v[2], " "))
        vim.api.nvim_buf_set_keymap(0, "n", "<leader><Enter>", "", {
          callback = function()
            kill_current_job()
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
              callback = kill_current_job,
            })

            local buf_number = vim.fn.bufwinnr(output_bufnr)

            if buf_number == -1 then
              vim.cmd("vsplit")
              vim.cmd("buffer " .. output_bufnr)
            end
          end,
          noremap = true,
          silent = true,
          desc = "Run make command",
        })
      end,
    })
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.keymap.set("n", "<localLeader><enter>", "<CMD>VimtexCompile<CR>")
  end,
})
