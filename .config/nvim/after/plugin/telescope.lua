local status, telescope = pcall(require, "telescope")
if (not status) then return end

local actions = require('telescope.actions')

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require 'telescope'.extensions.file_browser.actions

telescope.setup({
  defaults = {
    mappings = {
      n = {
        ['q'] = actions.close,
        ['<C-w>'] = actions.close
      },
      i = {
        ['<C-w>'] = actions.close
      }
    },
    extensions = {
      file_browser = {
        theme = "dropdown",
        hijack_netrw = true,
        mappings = {
          ['i'] = {
            ['<C-w>'] = function() vim.cmd('normal vbd') end,
          },
          ['n'] = {
            ['N'] = fb_actions.create,
            ['h'] = fb_actions.goto_parent_dir,
            ['/'] = function()
              vim.cmd('startinsert')
            end
          }
        }
      }
    },
    file_ignore_patterns = { "node_modules" }
  }
})

telescope.load_extension('file_browser')

local opts = { noremap = true, silent = true }
local file_broser_opts = { path = '%:p:h', cwd = telescope_buffer_dir(),
  respect_git_ignore = false, hidden = true, grouped = true, previewer = false, initial_mode = "normal",
  layout_config = { height = 40 } }

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, opts)
vim.keymap.set('n', '<leader>pb', builtin.buffers, opts)
vim.keymap.set('n', 'sf',
  function()
    telescope.extensions.file_browser.file_browser(file_broser_opts)
  end, opts)
vim.keymap.set('n', '<leader>ps',
  function()
    builtin.live_grep()
  end, opts)
