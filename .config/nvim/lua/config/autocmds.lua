-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust", "rs" },
  callback = function()
    vim.opt_local.makeprg = "cargo build"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java" },
  callback = function()
    vim.opt_local.makeprg = "java %"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp" },
  callback = function()
    vim.opt_local.makeprg = "clang++ %:p:h/*.cpp -o %:t:r && ./%:t:r"
  end,
})

function SearchAndOpenFile()
  local line = vim.fn.getline(".")
  local matches = { string.match(line, "(/[%w%.]+):(%d+):(%d+)") }

  if #matches >= 3 then
    local file_path = matches[1]
    local line_number = tonumber(matches[2])
    local column_number = tonumber(matches[3])

    -- Abre el archivo en la ruta especificada
    vim.cmd("edit " .. file_path)

    -- Configura el cursor en la línea y columna
    local bufnr = vim.fn.bufnr("%")
    local winnr = vim.fn.bufwinnr(bufnr)
    vim.api.nvim_win_set_cursor(winnr, { line_number, column_number })

    -- Resalta las coincidencias en el buffer de tipo "log"
    local log_bufnr = vim.fn.bufnr("log") -- Reemplaza "log" con el nombre de tu buffer
    local match_start = vim.fn.search(matches[0], "W", 0, log_bufnr)
    if match_start > 0 then
      local match_end = match_start + string.len(matches[0])
      local highlight_group = "Search" -- Puedes ajustar el grupo de resaltado según tu esquema de colores

      vim.api.nvim_buf_add_highlight(log_bufnr, -1, highlight_group, match_start - 1, match_end, -1)
    end
  else
    -- Si no se encuentra una coincidencia, simplemente presiona Enter
    return "<CR>"
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "log" },
  callback = function()
    SearchAndOpenFile()
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>", ":lua SearchAndOpenFile()<CR>", { noremap = true, silent = true })
  end,
})
