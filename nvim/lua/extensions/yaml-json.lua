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
    ft = {},
    keys = {
      {
        '<leader>ccr',
        function()
          require('ansible').run()
        end,
        desc = 'Code: Ansible [r]un playbook',
      },
      {
        '<leader>cca',
        '<cmd>set ft=yaml.ansible<cr>',
        desc = '[a]ttach yaml.ansible ft',
      },
    },
    config = function()
      -- detect ansible yaml files (auto :set ft=yaml.ansible)
      if vim.filetype then
        vim.filetype.add {
          pattern = {
            ['.*/host_vars/.*%.ya?ml'] = 'yaml.ansible',
            ['.*/group_vars/.*%.ya?ml'] = 'yaml.ansible',
            ['.*/group_vars/.*/.*%.ya?ml'] = 'yaml.ansible',
            ['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
            ['.*/roles/.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
            ['.*/roles/.*/handlers/.*%.ya?ml'] = 'yaml.ansible',
            -- maybe also add everything from ~/.ansible /etc/ansible dirs?
          },
        }
      else
        vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
          pattern = {
            '*/host_vars/*.yml',
            '*/host_vars/*.yaml',
            '*/group_vars/*.yml',
            '*/group_vars/*.yaml',
            '*/group_vars/*/*.yml',
            '*/group_vars/*/*.yaml',
            '*/playbooks/*.yml',
            '*/playbooks/*.yaml',
            '*/roles/*/tasks/*.yml',
            '*/roles/*/tasks/*.yaml',
            '*/roles/*/handlers/*.yml',
            '*/roles/*/handlers/*.yaml',
            -- maybe also add everything from ~/.ansible /etc/ansible dirs?
          },
          callback = function()
            vim.bo.filetype = 'yaml.ansible'
          end,
        })
      end

      if vim.fn.executable 'ansible-doc' then
        vim.bo.keywordprg = ':sp term://ansible-doc' -- spawns split term for hover docs (on 'K')
      end
      local fname = vim.api.nvim_buf_get_name(0)
      if fname:find 'tasks/' then
        local paths = {
          vim.bo.path,
          vim.fs.dirname(fname:gsub('tasks/', 'files/')),
          vim.fs.dirname(fname),
        }
        vim.bo.path = table.concat(paths, ',')
      end
      vim.bo.iskeyword = '@,48-57,_,192-255,.' -- needed for the entire "word" as args to be piped into ansible-doc <args> for hover docs (on 'K')
      -- vim.bo.iskeyword = ''
    end,
  },
}
