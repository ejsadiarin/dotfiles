-- Configures everything for C# (csharp, dotnet) programming language support
-- make sure to have atleast .NET 6 installed (for roslyn)

-- local config = {
--   filetypes = { 'csharp' },
--   handlers = {
--     ['textDocument/definition'] = require('omnisharp_extended').definition_handler,
--     ['textDocument/typeDefinition'] = require('omnisharp_extended').type_definition_handler,
--     ['textDocument/references'] = require('omnisharp_extended').references_handler,
--     ['textDocument/implementation'] = require('omnisharp_extended').implementation_handler,
--   },
-- }
return {
  { 'Hoffs/omnisharp-extended-lsp.nvim', lazy = true },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        omnisharp = {
          filetypes = { 'cs', 'csharp' },
          -- handlers = {
          --   ['textDocument/definition'] = require('omnisharp_extended').definition_handler,
          --   ['textDocument/typeDefinition'] = require('omnisharp_extended').type_definition_handler,
          --   ['textDocument/references'] = require('omnisharp_extended').references_handler,
          --   ['textDocument/implementation'] = require('omnisharp_extended').implementation_handler,
          -- },
          keys = {
            {
              'gd',
              function()
                require('omnisharp_extended').telescope_lsp_definitions()
              end,
              desc = '[G]oto [D]efinition',
            },
            {
              'gr',
              function()
                require('omnisharp_extended').telescope_lsp_references()
              end,
              desc = '[G]oto [R]eferences',
            },

            {
              '<leader>cD',
              function()
                require('omnisharp_extended').telescope_lsp_type_definition()
              end,
              desc = 'Type [D]efinition',
            },
            {
              'gI',
              function()
                require('omnisharp_extended').telescope_lsp_implementation()
              end,
              desc = '[G]oto [I]mplementation',
            },
          },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
      },
    },
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        -- C#
        'omnisharp', -- lsp
        'csharpier', -- lsp
        'netcoredbg', -- debugger
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'c_sharp' } },
  },

  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { 'csharpier' },
      },
      formatters = {
        csharpier = {
          command = 'dotnet-csharpier',
          args = { '--write-stdout' },
        },
      },
    },
  },

  {
    'mfussenegger/nvim-dap',
    optional = true,
    opts = function()
      local dap = require 'dap'
      if not dap.adapters['netcoredbg'] then
        require('dap').adapters['netcoredbg'] = {
          type = 'executable',
          command = vim.fn.exepath 'netcoredbg',
          args = { '--interpreter=vscode' },
          options = {
            detached = false,
          },
        }
      end
      for _, lang in ipairs { 'cs', 'fsharp', 'vb' } do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = 'netcoredbg',
              name = 'Launch file',
              request = 'launch',
              ---@diagnostic disable-next-line: redundant-parameter
              program = function()
                return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = '${workspaceFolder}',
            },
          }
        end
      end
    end,
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    opts = {
      -- automatic_installation = true,
      ensure_installed = {
        'netcoredbg',
      },
    },
  },
}

-- configure debugger (netcoredbg), see: https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#making-debugging-net-easier
-- local dap = require 'dap'
--
-- vim.g.dotnet_build_project = function()
--   local default_path = vim.fn.getcwd() .. '/'
--   if vim.g['dotnet_last_proj_path'] ~= nil then
--     default_path = vim.g['dotnet_last_proj_path']
--   end
--   local path = vim.fn.input('Path to your *proj file', default_path, 'file')
--   vim.g['dotnet_last_proj_path'] = path
--   local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
--   print ''
--   print('Cmd to execute: ' .. cmd)
--   local f = os.execute(cmd)
--   if f == 0 then
--     print '\nBuild: ✔️ '
--   else
--     print('\nBuild: ❌ (code: ' .. f .. ')')
--   end
-- end
--
-- vim.g.dotnet_get_dll_path = function()
--   local request = function()
--     return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
--   end
--
--   if vim.g['dotnet_last_dll_path'] == nil then
--     vim.g['dotnet_last_dll_path'] = request()
--   else
--     if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
--       vim.g['dotnet_last_dll_path'] = request()
--     end
--   end
--
--   return vim.g['dotnet_last_dll_path']
-- end
--
-- local config = {
--   {
--     type = 'coreclr',
--     name = 'launch - netcoredbg',
--     request = 'launch',
--     program = function()
--       if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
--         vim.g.dotnet_build_project()
--       end
--       return vim.g.dotnet_get_dll_path()
--     end,
--   },
-- }
--
-- dap.configurations.cs = config
-- dap.configurations.fsharp = config
--
-- vim.api.nvim_set_keymap('n', '<C-b>', ':lua vim.g.dotnet_build_project()<CR>', { noremap = true, silent = true })
