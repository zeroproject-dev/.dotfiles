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

local root_files = { "Makefile", "build.sh", "run.sh" }

local function check_and_run_root_file()
  local files = vim.fn.readdir(vim.fn.getcwd())

  for _, project_file in ipairs(files) do
    if vim.tbl_contains(root_files, project_file) then
      if project_file:lower() == "makefile" then
        return { "make" }
      else
        if string.match(project_file, "%.sh$") then
          return { "bash", project_file }
        end
      end
    end
  end

  return nil
end

for _, v in ipairs(make_files_commands) do
  for _, pattern in ipairs(v[1]) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = pattern,
      callback = function()
        local command = vim.fn.expandcmd(table.concat(v[2], " "))
        vim.api.nvim_buf_set_keymap(0, "n", "<leader><Enter>", "", {
          callback = function()
            local root_command = check_and_run_root_file()

            if root_command then
              command = vim.fn.expandcmd(table.concat(root_command, " "))
            end

            vim.cmd("vsplit | terminal " .. command)

            vim.cmd("startinsert")
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

vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  callback = function()
    vim.keymap.set(
      "n",
      "<leader><enter>",
      ":lua require('kulala').run()<CR>",
      { noremap = true, silent = true, desc = "Run http request" }
    )

    vim.keymap.set(
      "n",
      "<leader>yy",
      ":lua require('kulala').copy()<CR>",
      { noremap = true, silent = true, desc = "Copy curl command" }
    )

    vim.keymap.set(
      "n",
      "<leader>tt",
      ":lua require('kulala').toggle_view()<CR>",
      { noremap = true, silent = true, desc = "Toggle View" }
    )

    vim.keymap.set(
      "n",
      "<leader>n",
      ":lua require('kulala').jump_next()<CR>",
      { noremap = true, silent = true, desc = "Go next request" }
    )

    vim.keymap.set(
      "n",
      "<leader>N",
      ":lua require('kulala').jump_prev()<CR>",
      { noremap = true, silent = true, desc = "Go previous request" }
    )
  end,
})
