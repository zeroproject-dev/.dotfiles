local status, zen = pcall(require, "zen-mode")
if not status then return end

zen.setup {
  window = {
    width = 90,
    options = {
      number = true,
      relativenumber = true,
    }
  },
}

vim.keymap.set("n", "<leader>zz", function()
  zen.toggle()
  vim.wo.wrap = false
  ColorMyPencils()
end)

