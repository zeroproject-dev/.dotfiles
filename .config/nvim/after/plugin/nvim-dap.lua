local status, neodev = pcall(require, 'neodev')
if (not status) then return end

neodev.setup({
  library = { plugins = { 'nvim-dap-ui' }, types = true },
})
