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

-- Rebuilds the project before starting the debug session
---@param co thread
vim.g.dotnet_rebuild_project = function(co, path)
  vim.notify 'Building project'
  vim.fn.jobstart(string.format('dotnet build %s', path), {
    on_exit = function(_, return_code)
      if return_code == 0 then
        vim.notify 'Built successfully'
      else
        vim.notify('Build failed with exit code ' .. return_code)
      end
      coroutine.resume(co)
    end,
  })
  coroutine.yield()
end

return {
  {
    'GustavEikaas/easy-dotnet.nvim',
    ft = { 'cs', 'fsharp', 'vb' },
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local function get_secret_path(secret_guid)
        local path = ''
        local home_dir = vim.fn.expand '~'
        if require('easy-dotnet.extensions').isWindows() then
          local secret_path = home_dir .. '\\AppData\\Roaming\\Microsoft\\UserSecrets\\' .. secret_guid .. '\\secrets.json'
          path = secret_path
        else
          local secret_path = home_dir .. '/.microsoft/usersecrets/' .. secret_guid .. '/secrets.json'
          path = secret_path
        end
        return path
      end

      local dotnet = require 'easy-dotnet'
      -- Options are not required
      dotnet.setup {
        test_runner = {
          noBuild = true,
          noRestore = true,
        },
        ---@param action "test"|"restore"|"build"|"run"
        terminal = function(path, action)
          local commands = {
            run = function()
              return 'dotnet run --project ' .. path
            end,
            test = function()
              return 'dotnet test ' .. path
            end,
            restore = function()
              return 'dotnet restore ' .. path
            end,
            build = function()
              return 'dotnet build ' .. path
            end,
          }
          local command = commands[action]() .. '\r'
          vim.cmd 'vsplit'
          vim.cmd('term ' .. command)
        end,
        secrets = {
          path = get_secret_path,
        },
        csproj_mappings = true,
        auto_bootstrap_namespace = true,
      }

      -- Example command
      vim.api.nvim_create_user_command('Secrets', function()
        dotnet.secrets()
      end, {})

      -- Example keybinding
      vim.keymap.set('n', '<leader>cp', function()
        dotnet.run_project()
      end, { desc = 'Run Dotnet Project' })
    end,
  },

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
              '<leader>D',
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
      -- for more dap config info, see https://github.com/GustavEikaas/easy-dotnet.nvim?tab=readme-ov-file#advanced-example
      -- --> requires easy-dotnet, overseer plugins though

      local dap = require 'dap'
      if not dap.adapters['netcoredbg'] then
        require('dap').adapters['netcoredbg'] = {
          type = 'executable',
          command = vim.fn.exepath 'netcoredbg',
          args = { '--interpreter=vscode' },
          -- console = "internalConsole",
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
                -- if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
                --   vim.g.dotnet_rebuild_project()
                -- end
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
