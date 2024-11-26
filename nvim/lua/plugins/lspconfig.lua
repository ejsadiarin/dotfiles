return {
    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            {
                'williamboman/mason.nvim', -- NOTE: Must be loaded before dependants
                config = true,
            },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Allows extra capabilities provided by nvim-cmp
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function(_, opts)
            require('lspconfig.ui.windows').default_options.border = 'rounded'
            -- Brief aside: **What is LSP?**
            --
            -- LSP is an initialism you've probably heard, but might not understand what it is.
            --
            -- LSP stands for Language Server Protocol. It's a protocol that helps editors
            -- and language tooling communicate in a standardized fashion.
            --
            -- In general, you have a "server" which is some tool built to understand a particular
            -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
            -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
            -- processes that communicate with some "client" - in this case, Neovim!
            --
            -- LSP provides Neovim with features like:
            --  - Go to definition
            --  - Find references
            --  - Autocompletion
            --  - Symbol Search
            --  - and more!
            --
            -- Thus, Language Servers are external tools that must be installed separately from
            -- Neovim. This is where `mason` and related plugins come into play.
            --
            -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
            -- and elegantly composed help section, `:help lsp-vs-treesitter`

            --  This function gets run when an LSP attaches to a particular buffer.
            --    That is to say, every time a new file is opened that is associated with
            --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
            --    function will be executed to configure the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
                    -- to define small helper and utility functions so you don't have to repeat yourself.
                    --
                    -- In this case, we create a function that lets us more easily define mappings specific
                    -- for LSP related items. It sets the mode, buffer and description for us each time.
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    -- TODO: add snacks.nvim win, check if have snacks.nvim first, if not then fallback to native
                    -- hover doc configs
                    map('K', function()
                        vim.lsp.buf.hover({
                            border = "rounded"
                        })
                    end, 'Hover doc')

                    -- Jump to the definition of the word under your cursor.
                    --  This is where a variable was first declared, or where a function is defined, etc.
                    --  To jump back, press <C-t>.
                    map('gd', '<cmd>Trouble lsp_definitions toggle win.position=bottom<cr>', 'Goto [d]efinition')
                    -- map('gd', require('telescope.builtin').lsp_definitions, 'Goto [d]efinition')

                    -- Find references for the word under your cursor.
                    map('gr', '<cmd>Trouble lsp_references toggle win.position=bottom<cr>', 'Goto [r]eferences')
                    -- map('gr', require('telescope.builtin').lsp_references, 'Goto [r]eferences')

                    -- Jump to the implementation of the word under your cursor.
                    --  Useful when your language has ways of declaring types without an actual implementation.
                    map('gI', '<cmd>Trouble lsp_implementations toggle win.position=bottom<cr>', 'Goto [I]mplementation')
                    -- map('gI', require('telescope.builtin').lsp_implementations, 'Goto [I]mplementation')

                    -- Jump to the type of the word under your cursor.
                    --  Useful when you're not sure what type a variable is and you want to see
                    --  the definition of its *type*, not where it was *defined*.
                    map('<leader>D', '<cmd>Trouble lsp_type_definitions toggle win.position=bottom<cr>',
                        'Type [D]efinition')
                    -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

                    -- Fuzzy find all the symbols in your current document.
                    --  Symbols are things like variables, functions, types, etc.
                    map('<leader>ss', require('telescope.builtin').lsp_document_symbols, 'Document [s]ymbols')

                    -- Fuzzy find all the symbols in your current workspace.
                    --  Similar to document symbols, except searches over your entire project.
                    map('<leader>sS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace [S]ymbols')

                    -- Rename the variable under your cursor.
                    --  Most Language Servers support renaming across files, etc.
                    map('<leader>cr', vim.lsp.buf.rename, 'Code [r]ename')

                    -- Execute a code action, usually your cursor needs to be on top of an error
                    -- or a suggestion from your LSP for this to activate.
                    map('<leader>ca', vim.lsp.buf.code_action, 'Code [a]ction')

                    -- WARN: This is not Goto Definition, this is Goto Declaration.
                    --  For example, in C this would take you to the header.
                    map('gD', vim.lsp.buf.declaration, 'Goto [D]eclaration')

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                        local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end

                    -- The following code creates a keymap to toggle inlay hints in your
                    -- code, if the language server you are using supports them
                    --
                    -- This may be unwanted, since they displace some of your code (UPDATE 20241110: handled by snacks.nvim)
                    -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    --     map('<leader>uh', function()
                    --         vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    --     end, 'Toggle Inlay [h]ints')
                    -- end
                end,
            })

            -- LSP servers and clients are able to communicate to each other what features they support.
            --  By default, Neovim doesn't support everything that is in the LSP specification.
            --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
            --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
            -- code above is similar to: capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- Enable the following language servers
            --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
            --
            --  Add any additional override configuration in the following tables. Available keys are:
            --  - cmd (table): Override the default command used to start the server
            --  - filetypes (table): Override the default list of associated filetypes for the server
            --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
            --  - settings (table): Override the default settings passed when initializing the server.
            --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
            local servers = {
                -- clangd = {},
                -- gopls = {},
                -- pyright = {},
                -- rust_analyzer = {},
                -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
                --
                -- Some languages (like typescript) have entire language plugins that can be useful:
                --    https://github.com/pmizio/typescript-tools.nvim
                --
                -- But for many setups, the LSP (`ts_ls`) will work just fine
                -- ts_ls = {},
                --

                -- install lua_ls by default
                lua_ls = {
                    -- cmd = {...},
                    -- filetypes = { ...},
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                            telemetry = {
                                enable = false,
                            },
                            diagnostics = { disable = { 'missing-fields' } },
                            workspace = {
                                checkThirdParty = false,
                            },
                        },
                    },
                },
                gopls = {
                    cmd = { 'gopls', 'serve' },
                    filetypes = { 'go' },
                    settings = {
                        gopls = {
                            gofumpt = true,
                            codelenses = {
                                gc_details = false,
                                generate = true,
                                regenerate_cgo = true,
                                run_govulncheck = true,
                                test = true,
                                tidy = true,
                                upgrade_dependency = true,
                                vendor = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            analyses = {
                                fieldalignment = true,
                                nilness = true,
                                unusedparams = true,
                                unusedwrite = true,
                                useany = true,
                            },
                            usePlaceholders = true,
                            completeUnimported = true,
                            staticcheck = true,
                            directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
                            semanticTokens = true,
                        },
                    },
                    ---@param client vim.lsp.Client
                    on_init = function(client)
                        if client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
                            local semantic = client.config.capabilities.textDocument.semanticTokens
                            client.server_capabilities.semanticTokensProvider = {
                                full = true,
                                legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
                                range = true,
                            }
                        end
                    end,
                },
                ts_ls = {
                    enabled = false,
                    on_init = function()
                        -- disable ts_ls
                        return true
                    end,
                },
                vtsls = {
                    filetypes = {
                        'javascript',
                        'javascriptreact',
                        'javascript.jsx',
                        'typescript',
                        'typescriptreact',
                        'typescript.tsx',
                    },
                    settings = {
                        complete_function_calls = true,
                        vtsls = {
                            enableMoveToFileCodeAction = true,
                            autoUseWorkspaceTsdk = true,
                            experimental = {
                                completion = {
                                    enableServerSideFuzzyMatch = true,
                                },
                            },
                        },
                        typescript = {
                            updateImportsOnFileMove = { enabled = 'always' },
                            suggest = {
                                completeFunctionCalls = true,
                            },
                            inlayHints = {
                                enumMemberValues = { enabled = true },
                                functionLikeReturnTypes = { enabled = true },
                                parameterNames = { enabled = 'literals' },
                                parameterTypes = { enabled = true },
                                propertyDeclarationTypes = { enabled = true },
                                variableTypes = { enabled = false },
                            },
                        },
                        javascript = {
                            updateImportsOnFileMove = { enabled = 'always' },
                            suggest = {
                                completeFunctionCalls = true,
                            },
                            inlayHints = {
                                enumMemberValues = { enabled = true },
                                functionLikeReturnTypes = { enabled = true },
                                parameterNames = { enabled = 'literals' },
                                parameterTypes = { enabled = true },
                                propertyDeclarationTypes = { enabled = true },
                                variableTypes = { enabled = false },
                            },
                        },
                    },
                    on_init = function()
                        require('lspconfig.configs').vtsls = require('vtsls')
                            .lspconfig -- set default server config, optional but recommended
                    end,
                },
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
                jdtls = {
                    on_init = function()
                        return true
                    end,
                },
                jsonls = {
                    -- from lazyvim to lazy-load schemastore when needed
                    on_new_config = function(new_config)
                        new_config.settings.json.schemas = vim.tbl_deep_extend('force',
                            new_config.settings.json.schemas or {}, require('schemastore').json.schemas())
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
                -- yamlls = { --NOTE: this is already configured by the yaml-companion plugin
                --   capabilities = {
                --     textDocument = {
                --       foldingRange = {
                --         dynamicRegistration = false,
                --         lineFoldingOnly = true,
                --       },
                --     },
                --   },
                --   -- on_new_config = function(new_config)
                --   --   new_config.settings.yaml.schemas = vim.tbl_deep_extend('force', new_config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
                --   -- end,
                --   settings = {
                --     redhat = { telemetry = { enabled = false } },
                --     yaml = {
                --       keyOrdering = false,
                --       format = {
                --         enable = true,
                --       },
                --       validate = true,
                --       schemaStore = {
                --         -- You must disable built-in schemaStore support if you want to use
                --         -- this plugin and its advanced options like `ignore`.
                --         enable = false,
                --         -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                --         url = '',
                --       },
                --       -- schemas = require('schemastore').yaml.schemas(),
                --       -- schemas = {
                --       --   kubernetes = '*.yaml',
                --       --   ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
                --       --   ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
                --       --   ['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
                --       --   ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
                --       --   ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
                --       --   ['http://json.schemastore.org/ansible-playbook'] = '*play*.{yml,yaml}',
                --       --   ['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
                --       --   ['https://json.schemastore.org/dependabot-v2'] = '.github/dependabot.{yml,yaml}',
                --       --   ['https://json.schemastore.org/gitlab-ci'] = '*gitlab-ci*.{yml,yaml}',
                --       --   ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] = '*api*.{yml,yaml}',
                --       --   ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '*docker-compose*.{yml,yaml}',
                --       --   ['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] = '*flow*.{yml,yaml}',
                --       -- },
                --     },
                --   },
                -- },
                phpactor = {
                    enabled = true,
                    cwd = { 'phpactor', 'language-server' },
                    filetypes = { 'php' },
                    root_dir = function()
                        return vim.loop.cwd()
                    end
                    -- settings = {}
                },
                eslint = {
                    settings = {
                        -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
                        workingDirectories = { mode = 'auto' },
                    },
                },
                tailwindcss = {
                    -- exclude a filetype from the default_config
                    filetypes_exclude = { 'markdown' },
                    -- add additional filetypes to the default_config
                    filetypes_include = {},
                    -- to fully override the default_config, change the below
                    -- filetypes = {}
                },
                bashls = {},
                html = {},
                cssls = {},
                marksman = {},
                ansiblels = {},
                dockerls = {},
                sqlls = {
                    filetypes = { 'sql', 'mysql' },
                    root_dir = require('lspconfig.util').root_pattern '.sqllsrc.json',
                    settings = {},
                },
                docker_compose_language_service = {},
            }

            require('mason').setup {
                ui = {
                    border = 'rounded',
                },
            }

            -- You can add other tools here that you want Mason to install
            -- for you, so that they are available from within Neovim.
            local ensure_installed = vim.tbl_keys(servers or {})
            -- WARN: All LSP listed below will be AUTOMATICALLY INSTALLED, comment to disable
            -- do `:checkhealth` after to see installed status
            vim.list_extend(ensure_installed, {
                -- Lua
                'lua_ls',     -- lsp
                'stylua',     -- formatter
                -- Bash
                'bashls',     -- lsp
                'shellcheck', -- lint
                'shfmt',      -- formatter
                -- C
                'clangd',
                -- Go
                'gopls',
                'goimports',    -- for formatting imports
                'gofumpt',      -- gofmt
                'gomodifytags', -- add tags to struct fields
                'impl',         -- generate interface methods
                'delve',        -- debugger
                'golangci-lint',
                -- Python
                'basedpyright',                -- lsp
                'isort',                       -- sorter
                'black',                       -- python formatter
                'pylint',                      -- linter
                'debugpy',                     -- debugger
                -- HTML, CSS, JS, misc.
                'ts_ls',                       -- javascript & typescript lsp
                'vtsls',                       -- javascript & typescript lsp
                'emmet-language-server',
                'html-lsp',                    -- html lsp
                'css-lsp',                     -- css lsp
                'tailwindcss-language-server', -- tailwind lsp
                'eslint_d',                    -- linter daemon
                'prettierd',                   -- formatter daemon
                'js-debug-adapter',            -- debugger
                -- YAML, JSON, Docker, configs, etc.
                'yamlls',                      -- linter
                'jsonls',
                -- Docker
                'dockerls',                        -- lsp
                'docker_compose_language_service', -- lsp for compose
                'hadolint',                        -- linter
                -- Ansible
                'ansiblels',                       -- lsp
                'ansible-lint',                    -- linter
                -- Java
                'jdtls',
                'java-debug-adapter',
                'java-test',
                -- C#
                'omnisharp',         -- lsp
                'csharpier',         -- lsp
                'netcoredbg',        -- debugger
                -- Markdown
                'marksman',          -- lsp
                -- 'markdownlint-cli2', -- linter
                'markdown-toc',      -- table of contents formatter
                -- SQL
                'sqlls',             -- lsp
                'sqlfluff',          -- linter
                -- PHP
                'phpactor',          -- lsp
                'php-debug-adapter', -- debugger
                'phpcs',             -- linter
                'php-cs-fixer',      -- formatter
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            -- see plugins/mason.lua for 'mason' and 'mason-lspconfig' configurations
            require('mason-lspconfig').setup {
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed by the server configuration above.
                        -- Useful when disabling certain features of an LSP (for example, turning off formatting for ts_ls)
                        -- configure capabilities of ALL servers to this 'extended capabilities' (with 'cmp_nvim_lsp')
                        -- server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {}) -- like: capabilities = require('cmp_nvim_lsp').default_capabilities(),
                        -- NOTE: instead of just capabilities, just insert capabilities property of each server to its opts table
                        local server_opts = vim.tbl_deep_extend('force', { capabilities = capabilities },
                            servers[server_name] or {})
                        if server_opts.enabled == false then
                            return
                        end

                        if opts.setup[server_name] then
                            if opts.setup[server_name](server_name, server_opts) then
                                return
                            end
                        elseif opts.setup['*'] then
                            if opts.setup['*'](server_name, server_opts) then
                                return
                            end
                        end
                        require('lspconfig')[server_name].setup(server_opts)
                    end,
                },
            }
            --
        end,
    },
}

-- NOTE: Good resources for structuring modular configs:
-- https://github.com/VonHeikemen/lazy-template/blob/main/lua/plugins/lspconfig.lua
-- THIS: https://github.com/MuhametSmaili/nvim/blob/main/lua/smaili/plugins/lsp/init.lua
