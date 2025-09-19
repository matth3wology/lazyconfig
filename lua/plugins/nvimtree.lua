return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,                    -- load immediately (so mappings work at startup)
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  config = function()
    -- Disable netrw (recommended by nvim-tree)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Keymaps
    vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")
    vim.keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>")

    -- Enable highlight groups
    vim.opt.termguicolors = true

    -- Custom on_attach
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = false,
        }
      end

      -- Default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- Custom mappings
      vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
      vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
    end

    -- Setup
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      on_attach = my_on_attach,
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })
  end,
}
