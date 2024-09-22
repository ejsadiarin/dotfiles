-- Configuration for YAML, JSON, Docker, and Ansible support

return {

  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false, -- last release is way too old
  },

  {
    'someone-stole-my-name/yaml-companion.nvim',
    ft = { 'yaml', 'yml' },
    opts = {
      -- Additional schemas available in Telescope picker
      builtin_matchers = {
        kubernetes = { enabled = true },
        cloud_init = { enabled = true },
      },
      -- Additional schemas available in Telescope picker
      schemas = {
        --{
        --name = "Kubernetes 1.22.4",
        --uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
        --},
        {
          {
            name = 'Argo CD Application',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
          },
          {
            name = 'SealedSecret',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json',
          },
          -- schemas below are automatically loaded, but added
          -- them here so that they show up in the statusline
          {
            name = 'Kustomization',
            uri = 'https://json.schemastore.org/kustomization.json',
          },
          {
            name = 'GitHub Workflow',
            uri = 'https://json.schemastore.org/github-workflow.json',
          },
        },
      },

      -- Pass any additional options that will be merged in the final LSP config
      lspconfig = {
        flags = {
          debounce_text_changes = 150,
        },
        settings = {
          redhat = { telemetry = { enabled = false } },
          yaml = {
            validate = true,
            format = { enable = true },
            hover = true,
            schemaStore = {
              enable = true,
              url = 'https://www.schemastore.org/api/json/catalog.json',
            },
            schemaDownload = { enable = true },
            schemas = {},
            trace = { server = 'debug' },
          },
        },
      },
    },
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function(_, opts)
      local cfg = require('yaml-companion').setup {
        -- Additional schemas available in Telescope picker
        builtin_matchers = {
          kubernetes = { enabled = true },
          cloud_init = { enabled = true },
        },
        -- Additional schemas available in Telescope picker
        schemas = {
          {
            name = 'Kubernetes 1.22.4',
            uri = 'https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json',
          },
          {
            name = 'Kubernetes 1.27.12',
            uri = 'https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.27.12-standalone-strict/all.json',
          },
          {
            name = 'Kubernetes 1.26.14',
            uri = 'https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.26.14-standalone-strict/all.json',
          },
          {
            name = 'Argo CD Application',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
          },
          {
            name = 'SealedSecret',
            uri = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json',
          },
          -- schemas below are automatically loaded, but added
          -- them here so that they show up in the statusline
          {
            name = 'Kustomization',
            uri = 'https://json.schemastore.org/kustomization.json',
          },
          {
            name = 'GitHub Workflow',
            uri = 'https://json.schemastore.org/github-workflow.json',
          },
        },

        -- Pass any additional options that will be merged in the final LSP config
        lspconfig = {
          flags = {
            debounce_text_changes = 150,
          },
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              validate = true,
              format = { enable = true },
              hover = true,
              schemaStore = {
                -- enable = true,
                -- url = 'https://www.schemastore.org/api/json/catalog.json',
                enable = false,
                url = '',
              },
              schemaDownload = { enable = true },
              -- schemas from store, matched by filename
              -- loaded automatically
              schemas = {},
              -- schemas = require('schemastore').yaml.schemas(),
              -- schemas = require('schemastore').yaml.schemas {
              --   select = {
              --     'kustomization.yaml',
              --     'GitHub Workflow',
              --   },
              -- },
              trace = { server = 'debug' },
            },
          },
        },
      }
      require('lspconfig')['yamlls'].setup(cfg)
      require('telescope').load_extension 'yaml_schema'
    end,
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
