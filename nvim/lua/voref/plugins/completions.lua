return {
  -- Autocomplete source for LSP
  { "hrsh7th/cmp-nvim-lsp" },

  -- Snippet system and dependencies
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip", -- Integration of LuaSnip with cmp
      "rafamadriz/friendly-snippets", -- Collection of predefined snippets
    },
  },

  -- Main configuration for nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load VSCode snippets only if LuaSnip is present
      if luasnip then
        require("luasnip.loaders.from_vscode").lazy_load()
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Windows with borders for better visualization
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- Key mappings for autocomplete
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Automatically select the first item
        }),

        -- Prioritized autocomplete sources
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- Snippet support
        }, {
          { name = "buffer" }, -- Suggestions based on the current buffer
        }),
      })
    end,
  },
}
