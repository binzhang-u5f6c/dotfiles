return {
  {
    "hrsh7th/cmp-nvim-lsp",
      opts = {}
  },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  {
    "hrsh7th/nvim-cmp",
      config = function()
        local cmp = require("cmp")
        cmp.setup({
          snippet = {
            expand = function(args)
              -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
              -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
              -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
              -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
              -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

              -- For `mini.snippets` users:
              -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
              -- insert({ body = args.body }) -- Insert at cursor
              -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
              -- require("cmp.config").set_onetime({ sources = {} })
            end,
          },
          window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          }),
          sources = {
            { name = "buffer" },
            { name = "path" },
            { name = "nvim_lsp" },
            -- { name = "vsnip" }, -- For vsnip users.
            -- { name = "luasnip" }, -- For luasnip users.
            -- { name = "ultisnips" }, -- For ultisnips users.
            -- { name = "snippy" }, -- For snippy users.
          },
        })
        cmp.setup.cmdline({ "/", "?" }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          }
        })
        cmp.setup.cmdline(":" , {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "path" },
            { name = "cmdline" },
          },
          matching = { disallow_symbol_nonprefix_matching = false },
        })
      end
  },
}
