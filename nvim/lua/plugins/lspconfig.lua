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
    config = function()
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

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>cD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ss', require('telescope.builtin').lsp_document_symbols, 'Document [s]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>sS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>cr', vim.lsp.buf.rename, 'Code [r]ename')
          -- TODO: add grug_far plugin here for search/replace <leader>sr

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, 'Code [A]ction')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

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
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>uh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay [h]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      -- code above is similar to: capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup {
        ui = {
          border = 'rounded',
        },
      }

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        -- 'prettierd',
        -- 'prettier',
        -- 'isort', -- python formatter
        -- 'black', -- python formatter
        -- 'pylint',
        -- 'eslint_d',
      })
      require('mason-tool-installer').setup {
        ensure_installed = {
          'stylua', -- Used to format Lua code
          -- 'prettierd',
          -- 'prettier',
          -- 'isort', -- python formatter
          -- 'black', -- python formatter
          -- 'pylint',
          -- 'eslint_d',
        },
      }

      require('mason-lspconfig').setup {
        handlers = {
          -- See :help mason-lspconfig-dynamic-server-setup
          function(server_name) -- default handler
            -- See :help lspconfig-setup
            require('lspconfig')[server_name].setup {}
          end,

          -- NOTE: This is the LSP configuration handlers
          -- Enable the following language servers.
          -- Feel free to add/remove any LSPs that you want here. They will automatically be installed.
          --
          --  Add any additional override configuration in the following tables. Available keys are:
          --  - cmd (table): Override the default command used to start the server
          --  - filetypes (table): Override the default list of associated filetypes for the server
          --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
          --  - settings (table): Override the default settings passed when initializing the server.
          --
          --  For example: (to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/)
          --   lua_ls = {
          --     cmd = {...},
          --     filetypes = { ...},
          --     capabilities = {},
          --     settings = {...}
          --
          --	...etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
          --  -- Some languages (like typescript) have entire language plugins that can be useful:
          --  --    https://github.com/pmizio/typescript-tools.nvim
          --  --
          --  -- But for many setups, the LSP (`tsserver`) will work just fine
          --  tsserver = {},
          --

          ['lua_ls'] = function()
            -- if you install the language server for lua it will load the config from lua/plugins/lsp/lua_ls.lua
            require 'plugins.lsp.lua_ls'
          end,
          -- ['gopls'] = function()
          --   require 'plugins.lsp.gopls'
          -- end,
          -- ['pyright'] = function()
          --   -- if you install the language server for lua it will
          --   -- load the config from lua/plugins/lsp/lua_ls.lua
          --   -- require('plugins.lsp.lua_ls')
          -- end,
        },
      }
    end,
  },
}

-- Good resources for structuring modular configs:
-- https://github.com/VonHeikemen/lazy-template/blob/main/lua/plugins/lspconfig.lua
