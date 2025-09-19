return {
  'windwp/nvim-ts-autotag',
  dependencies = {
    'windwp/nvim-autopairs',
    'm4xshen/autoclose.nvim'
  },
  config = function()
    require("autoclose").setup {
      ["<"] = { escape = true, close = true, pair = "<>" },
    }
  end
}
