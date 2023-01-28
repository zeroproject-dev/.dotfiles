local state, saga = pcall(require, 'lspsaga')
if not state then return end

saga.setup({
  outline = {
    win_position = "left"
  }
})

local opts = { noremap = false, silent = true }

-- vim.keymap.set('n','<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<cr>', opts)
vim.keymap.set('n', '<A-.>', '<Cmd>Lspsaga show_cursor_diagnostics<cr>', opts)
vim.keymap.set({ 'n', 't' }, '<S-t>', '<Cmd>Lspsaga term_toggle<cr>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<cr>', opts)
vim.keymap.set('i', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<cr>', opts)
vim.keymap.set('n', '<leader>r', '<Cmd>Lspsaga rename<CR>', {noremap = true})
vim.keymap.set('n', '<leader>o', '<Cmd>Lspsaga outline<CR>', opts)

local codeaction = require('lspsaga.codeaction')

vim.keymap.set('n', '<C-.>', function()
  codeaction:code_action()
end, { silent = true })

vim.keymap.set('v', '<C-.>', function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
  codeaction:range_codeaction()
end, { silent = true })
