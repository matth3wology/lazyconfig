return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
  },
  config = function()
    local builtin = require('telescope.builtin')
    local trouble = require('trouble.sources.telescope')
    local actions = require('telescope.actions')
    local telescope = require('telescope')

    -- Initial telescope setup
    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<C-t>'] = trouble.open_with_trouble,
            ['<C-n>'] = actions.select_vertical,
            ['<C-p>'] = actions.select_horizontal,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
          },
          n = {
            ['<C-t>'] = trouble.open_with_trouble,
          },
        },
      },
    }

    -- Used to find files in the directory
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

    -- Used to search for a word and grep through files
    -- You need to install ripgrep CLI command
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Search: ") });
    end)

    -- Used to search through .git files in the directory
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
  end
}
