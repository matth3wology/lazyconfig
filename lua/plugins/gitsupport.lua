return {
  'tpope/vim-fugitive',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'numToStr/Comment.nvim',
    'rhysd/conflict-marker.vim',
  },
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    require('gitsigns').setup()
    require('Comment').setup()
  end
}
