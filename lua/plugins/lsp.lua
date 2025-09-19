return {
  'VonHeikemen/lsp-zero.nvim',
  lazy = false,
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'neovim/nvim-lspconfig', -- must include this
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'mfussenegger/nvim-lint',
    'mhartington/formatter.nvim',
  },
  config = function()
    local lsp = require('lsp-zero')
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    local mason_tool = require('mason-tool-installer')
    local luasnip = require('luasnip')
    local cmp = require('cmp')
    local cmp_lsp = require('cmp_nvim_lsp')
    local util = require('lspconfig.util')

    -- Load snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_snipmate").lazy_load()

    -- Configure linters
    require("lint").linters_by_ft = {
      cpp = { 'cpplint' },
      c = { 'cpplint' },
    }

    -- Mason setup
    mason.setup({ PATH = "prepend" })
    mason_lspconfig.setup({
      ensure_installed = { 'rust_analyzer', 'gopls', 'lua_ls', 'pyright', 'ts_ls', 'eslint' },
    })
    mason_tool.setup({
      ensure_installed = { 'cssls' }
    })

    -- CMP setup
    cmp.setup({
      snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() else fallback() end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
      }),
      window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered({
          winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None'
        }),
      },
    })

    -- lsp-zero on_attach for keymaps and autoformat
    lsp.on_attach(function(_, bufnr)
      lsp.default_keymaps({ buffer = bufnr })
      lsp.buffer_autoformat()
    end)

    -- AutoSave linting
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function() require('lint').try_lint() end
    })
  end
}
