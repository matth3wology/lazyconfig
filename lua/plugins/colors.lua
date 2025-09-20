return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    dependencies = {
      'rose-pine/neovim',
      'folke/tokyonight.nvim',
      'catppuccin/nvim',
      'hardhackerlabs/theme-vim',
      'thedenisnikulin/vim-cyberpunk',
      'nyoom-engineering/oxocarbon.nvim',
      'xiyaowong/transparent.nvim',
      'UtkarshVerma/molokai.nvim',
      'scottmckendry/cyberdream.nvim',
    },
    config = function()
      vim.cmd [[colorscheme molokai]]
    end,
  },
}
