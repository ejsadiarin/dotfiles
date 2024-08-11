-- Configuration for YAML, JSON, Docker, and Ansible support

return {
  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false, -- last release is way too old
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ansiblels = {},
        dockerls = {},
        docker_compose_language_service = {},
        yamlls = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          -- from lazyvim to lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend('force', new_config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = '',
              },
              -- schemas = require('schemastore').yaml.schemas(),
            },
          },
        },
        jsonls = {
          -- from lazyvim to lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.json.schemas = vim.tbl_deep_extend('force', new_config.settings.json.schemas or {}, require('schemastore').json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = {
                enable = true,
              },
              -- schemas = require('schemastore').json.schemas(),
            },
          },
        },
      },
      setup = {},
    },
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        -- Docker
        'dockerls', -- lsp
        'docker_compose_language_service', -- lsp for compose
        'hadolint', -- linter

        -- Ansible
        'ansiblels', -- lsp
        'ansible-lint', -- linter
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'yaml',
        'json5',
        'dockerfile',
        'json',
        'jsonc',
      },
    },
  },

  { -- Linting
    'mfussenegger/nvim-lint',
    optional = true,
    opts = {
      linters_by_ft = {
        dockerfile = { 'hadolint' },
      },
    },
  },

  {
    'mfussenegger/nvim-ansible',
    keys = {
      {
        '<leader>car',
        function()
          require('ansible').run()
        end,
        desc = 'Code: [a]nsible [r]un playbook',
      },
    },
  },
}
