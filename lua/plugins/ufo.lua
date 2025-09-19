return {
  "kevinhwang91/nvim-ufo",
  lazy = false,
  dependencies = {
    'kevinhwang91/promise-async'
  },
  config = function()
    vim.o.foldcolumn = '0' -- '0' is not bad
    vim.o.foldlevel = 180  -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 180
    vim.o.foldenable = true

    local ftMap = {
      vim = 'indent',
      python = { 'indent' },
      git = ''
    }
    require('ufo').setup({
      open_fold_hl_timeout = 150,
      close_fold_kinds_for_ft = {
        default = {},
      },
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = 'Normal:Folded',
          winblend = 0
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']',
          peekFoldedLinesUnderCursor = ''
        }
      },
      provider_selector = function(bufnr, filetype, buftype)
        -- if you prefer treesitter provider rather than lsp,
        -- return ftMap[filetype] or {'treesitter', 'indent'}
        -- return ftMap[filetype]
        return { 'treesitter', 'indent' }

        -- refer to ./doc/example.lua for detail
      end
    })
    vim.keymap.set('n', 'zm', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zn', require('ufo').closeAllFolds)
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
    vim.keymap.set('n', 'zR', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)d,
  end
}
