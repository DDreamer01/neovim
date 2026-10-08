-- ==========================================================================
--  Autocompletion & Snippets
-- ==========================================================================

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- LSP completion source
    "hrsh7th/cmp-buffer",       -- Text within current buffer
    "hrsh7th/cmp-path",         -- File system paths
    "saadparwaiz1/cmp_luasnip",  -- Snippet completions
    "L3MON4D3/LuaSnip",         -- Snippet engine
    "rafamadriz/friendly-snippets", -- Collection of common snippets
    "onsails/lspkind.nvim",     -- VS Code-like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load friendly-snippets community snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
      },
      mapping = cmp.mapping.preset.insert({
        -- Navigate completion list
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- Trigger completion menu manually
        ["<C-Space>"] = cmp.mapping.complete(),
        -- Close completion menu
        ["<C-e>"] = cmp.mapping.abort(),
        -- Confirm selection (CR confirms selected item; if nothing selected, normal newline)
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        -- Super-tab behavior
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          menu = {
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          },
        }),
      },
    })
  end,
}
