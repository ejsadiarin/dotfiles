return {
  {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap',
    -- lazy = true,
    event = 'VeryLazy', -- 'VeryLazy'
    -- cmd = { 'DapContinue', 'DapNew', 'DapToggleBreakpoint' },
    -- NOTE: And you can specify dependencies as well
    dependencies = {
      -- Creates a beautiful debugger UI
      {
        'rcarriga/nvim-dap-ui',
      },

      -- Required dependency for nvim-dap-ui
      {
        'nvim-neotest/nvim-nio',
      },

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      {
        'theHamsta/nvim-dap-virtual-text',
        -- event = 'VeryLazy',
        opts = {
          -- enable this plugin (the default)
          enabled = true,
          -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          enabled_commands = true,
          -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          highlight_changed_variables = true,
          -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          highlight_new_as_changed = false,
          -- show stop reason when stopped for exceptions
          show_stop_reason = true,
          -- prefix virtual text with comment string
          commented = false,
          -- only show virtual text at first definition (if there are multiple)
          only_first_definition = true,
          -- show virtual text on all all references of the variable (not only definitions)
          all_references = false,
          -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
          filter_references_pattern = '<module',

          -- *** Experimental Features ****:

          -- position of virtual text, see `:h nvim_buf_set_extmark()`
          virt_text_pos = 'eol',
          -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
          all_frames = false,
          -- show virtual lines instead of virtual text (will flicker!)
          virt_lines = false,
          -- position the virtual text at a fixed window column (starting from the first text column) ,
          virt_text_win_col = nil,
        },
      },

      -- Add your own debuggers here
      {
        'leoluz/nvim-dap-go',
      },
    },
    keys = function(_, keys)
      local dap = require 'dap'
      local dapui = require 'dapui'
      return {
        -- Basic debugging keymaps, feel free to change to your liking!
        { '<leader>dd', dap.continue, desc = 'Debug: Start/Continue' },
        { '<leader>di', dap.step_into, desc = 'Debug: Step [i]nto' },
        { '<leader>do', dap.step_over, desc = 'Debug: Step [o]ver' },
        { '<leader>dO', dap.step_out, desc = 'Debug: Step [O]ut' },
        { '<leader>db', dap.toggle_breakpoint, desc = 'Debug: Toggle [b]reakpoint' },
        {
          '<leader>dB',
          function()
            dap.set_breakpoint(vim.fn.input 'Debug: [B]reakpoint condition: ')
          end,
          desc = 'Debug: Set Breakpoint',
        },
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        { '<leader>du', dapui.toggle, desc = 'Debug: Open [u]I' },
        unpack(keys),
      }
    end,
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {
          function(config)
            -- all sources with no handler get passed here

            -- Keep original functionality
            require('mason-nvim-dap').default_setup(config)
          end,
          -- python = function(config)
          --   config.adapters = {
          --     type = 'executable',
          --     command = '/usr/bin/python3',
          --     args = {
          --       '-m',
          --       'debugpy.adapter',
          --     },
          --   }
          --   require('mason-nvim-dap').default_setup(config) -- don't forget this!
          -- end,
          -- go = function (config)
          -- end
        },

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          -- 'delve',
          'js-debug-adapter',
          'debugpy',
          'java-debug-adapter',
          'netcoredbg',
        },
      }

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          -- enabled = true,
          -- element =
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- -- Install golang specific config
      -- require('dap-go').setup {
      --   delve = {
      --     -- On Windows delve must be run attached or it crashes.
      --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
      --     detached = vim.fn.has 'win32' == 0,
      --   },
      -- }
    end,
  },
}
