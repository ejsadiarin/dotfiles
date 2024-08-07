return {
  -- Highlight, edit, and navigate code (TREESITTER)
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = 'VeryLazy',
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require('lazy.core.loader').add_to_rtp(plugin)
      require 'nvim-treesitter.query_predicates'
    end,
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-treesitter/nvim-treesitter-context',
        event = 'VeryLazy',
        config = true,
        keys = {
          { '<leader>uc', '<cmd>TSContextToggle<CR>', desc = 'Toggle TSContext' },
          {
            '[e',
            ":lua require('treesitter-context').go_to_context()<cr>",
            silent = true,
            desc = 'Go to context (treesitter)',
          },
        },
      },
      'nvim-treesitter/nvim-treesitter-textobjects',

      {
        'windwp/nvim-ts-autotag',
        event = 'VeryLazy',
      },
    },
    opts = {
      -- Autoinstall languages that are not installed
      auto_install = true,
      ensure_installed = {
        -- 'go',
        -- 'gomod',
        -- 'gowork',
        -- 'gosum',
        'bash',
        'yaml',
        'dockerfile',
        'python',
        'json',
        'vim',
        'vimdoc', -- this is "help"
        'markdown',
        'markdown_inline',

        'lua',
        'luadoc',

        'c',
        'cmake',
        'diff',

        'html',
        'css',
        'javascript',
        'tsx',
        'typescript',
        'jsdoc',
        'json',
        'json5',
        'jsonc',

        'java',
        'c_sharp',

        'sql',
        'toml',
        'gitignore',
        'gitcommit',
        'git_rebase',
        'query',
        'regex',
        'xml',
      },
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        -- disable = { "tsx", "astro" },
        additional_vim_regex_highlighting = false,
        -- additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = {
        enable = true,
        disable = { 'ruby' },
      },
      autotag = { enable = true }, -- nvim-ts-autotag
      incremental_selection = {
        enable = true,
        keymaps = {
          -- init_selection = "<c-space>",
          -- node_incremental = "<c-space>",
          -- scope_incremental = "<c-s>",
          -- node_decremental = "<c-backspace>",
        },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        -- lint_events = { "BufWrite", "CursorHold" },
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']f'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = false,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
}
