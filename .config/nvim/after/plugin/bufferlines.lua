local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

bufferline.setup {
  options = {
    numbers = "none",
    close_command = "bdelete! %d",
    middle_mouse_command = "bdelete! %d",
    mode = 'tabs',
    separator_style = 'slant',
    always_show_bufferline = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = true,
    color_icons = true,
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    name_formatter = function(buf)
      return vim.fn.fnamemodify(buf.name, ':t')
    end,
    max_name_length = 18,
    max_prefix_length = 15,
    truncate_names = true,
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = true,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true
      }
    },
  },
}

-- vim.api.nvim_set_keymap('n', '<leader>0', ':BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
