-- TODO: install noice nvim
return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      routes = {
        filter = {
          event = 'notify',
          find = 'No information available',
        },
        opts = { skip = true },
      },
      cmdline = {
        enabled = false,
      },
      messages = {
        enabled = false,
      },
      notify = {
        enabled = true,
        view = 'notify',
      },
      lsp = {
        progress = {
          enabled = false,
          -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          --- @type NoiceFormat|string
          format = 'lsp_progress',
          --- @type NoiceFormat|string
          format_done = 'lsp_progress_done',
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = 'mini',
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
        hover = {
          enabled = true,
          silent = true, -- set to true to not show a message if hover is not available
          view = 'hover', -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {}, -- merged with defaults from documentation
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
            throttle = 50, -- Debounce lsp signature help request by 50ms
          },
          view = nil, -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {}, -- merged with defaults from documentation
        },
        message = {
          -- Messages shown by lsp servers
          enabled = true,
          view = 'notify',
        },
        -- defaults for hover and signature help
        documentation = {
          view = 'hover',
          ---@type NoiceViewOptions
          opts = {
            lang = 'markdown',
            replace = true,
            render = 'plain',
            format = { '{message}' },
            win_options = { concealcursor = 'n', conceallevel = 3 },
          },
        },
      },
      commands = {
        history = {
          -- options for the message history that you get with `:Noice`
          view = 'popup',
          opts = { enter = true, format = 'details' },
          filter = {
            any = {
              { event = 'notify' },
              { error = true },
              { warning = true },
              { event = 'msg_show', kind = { '' } },
              { event = 'lsp', kind = 'message' },
            },
          },
        },
        -- :Noice last
        last = {
          view = 'popup',
          opts = { enter = true, format = 'details' },
          filter = {
            any = {
              { event = 'notify' },
              { error = true },
              { warning = true },
              { event = 'msg_show', kind = { '' } },
              { event = 'lsp', kind = 'message' },
            },
          },
          filter_opts = { count = 1 },
        },
        -- :Noice errors
        errors = {
          -- options for the message history that you get with `:Noice`
          view = 'popup',
          opts = { enter = true, format = 'details' },
          filter = { error = true },
          filter_opts = { reverse = true },
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
}
