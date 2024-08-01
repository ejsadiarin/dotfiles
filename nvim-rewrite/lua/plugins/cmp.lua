return {
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}
      local compare = require 'cmp.config.compare'

      -- for Copilot <TAB> completion
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match '^%s*$' == nil
      end

      cmp.setup {
        window = {
          completion = {
            side_padding = 1,
            winhighlight = 'Normal:FloatNormal,FloatBorder:FloatNormal,CursorLine:TelescopeSelection,Search:None',
            border = 'rounded',
          },
          -- completion = {
          --   side_padding = 0,
          --   col_offset = 3,
          --   winhighlight = "Normal:FloatNormal,FloatBorder:FloatNormal,CursorLine:TelescopeSelection,Search:None",
          --   border = "rounded",
          -- },
          documentation = {
            side_padding = 2,
            winhighlight = 'Normal:FloatNormal,FloatBorder:FloatNormal,CursorLine:TelescopeSelection,Search:None',
            border = 'rounded',
            -- focusable = true,
          },
        },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          -- ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          ['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps

          -- Copilot TAB
          ['<Tab>'] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            else
              fallback()
            end
          end),
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'copilot', priority = 100 },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },

        -- HACK: fix this missing properties
        -- sorting = defaults.sorting,
        sorting = {
          -- priority_weight = function(entry)
          --   if entry.completion_item.kind == cmp.lsp.CompletionItemKind.Keyword then
          --     return 1000
          --   end
          -- end,
          comparators = {
            -- Original order: https://github.com/hrsh7th/nvim-cmp/blob/538e37ba87284942c1d76ed38dd497e54e65b891/lua/cmp/config/default.lua#L65-L74
            -- Definitions of compare function https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/compare.lua
            compare.offset,
            compare.recently_used, -- higher
            compare.score,
            compare.exact, -- lower
            compare.kind, -- higher (prioritize snippets)
            compare.locality,
            compare.length,
            compare.order,
          },
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, item)
            -- load lspkind icons
            -- item.kind = string.format(" %s  %s", user_icons.kinds[item.kind], item.kind)

            local icons = {
              Array = ' ',
              Boolean = '󰨙 ',
              Class = ' ',
              Codeium = '󰘦 ',
              Color = ' ',
              Control = ' ',
              Collapsed = ' ',
              Constant = '󰏿 ',
              Constructor = ' ',
              Copilot = ' ',
              Enum = ' ',
              EnumMember = ' ',
              Event = ' ',
              Field = ' ',
              File = ' ',
              Folder = ' ',
              Function = '󰊕 ',
              Interface = ' ',
              Key = ' ',
              Keyword = ' ',
              Method = '󰊕 ',
              Module = ' ',
              Namespace = '󰦮 ',
              Null = ' ',
              Number = '󰎠 ',
              Object = ' ',
              Operator = ' ',
              Package = ' ',
              Property = ' ',
              Reference = ' ',
              Snippet = ' ',
              String = ' ',
              Struct = '󰆼 ',
              TabNine = '󰏚 ',
              Text = ' ',
              TypeParameter = ' ',
              Unit = ' ',
              Value = ' ',
              Variable = '󰀫 ',
            }
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end

            item.menu = ({
              cmp_tabnine = '[Tabnine]',
              copilot = '[Copilot]',
              spell = '[Spell]',
              buffer = '[Buffer]',
              orgmode = '[Org]',
              look = '[Dictionary]',
              nvim_lsp = '[LSP]',
              git = '[Git]',
              nvim_lua = '[Lua]',
              path = '[Path]',
              tmux = '[Tmux]',
              latex_symbols = '[Latex]',
              luasnip = '[Snippet]',
            })[entry.source.name]

            local label = item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, 50)
            if truncated_label ~= label then
              item.abbr = truncated_label .. '...'
            end

            return item
          end,
        },
      }
    end,
  },
}
