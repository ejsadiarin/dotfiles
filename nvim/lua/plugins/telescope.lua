return {
    { -- Fuzzy Finder (files, lsp, etc)
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        -- cmd = 'Telescope',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                'nvim-telescope/telescope-fzf-native.nvim',

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = 'make',

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
        },
        config = function()
            -- Telescope is a fuzzy finder that comes with a lot of different things that
            -- it can fuzzy find! It's more than just a "file finder", it can search
            -- many different aspects of Neovim, your workspace, LSP, and more!
            --
            -- The easiest way to use Telescope, is to start by doing something like:
            --  :Telescope help_tags
            --
            -- After running this command, a window will open up and you're able to
            -- type in the prompt window. You'll see a list of `help_tags` options and
            -- a corresponding preview of the help.
            --
            -- Two important keymaps to use while in Telescope are:
            --  - Insert mode: <c-/>
            --  - Normal mode: ?
            --
            -- This opens a window that shows you all of the keymaps for the current
            -- Telescope picker. This is really useful to discover what Telescope can
            -- do as well as how to actually do it!

            local actions = require 'telescope.actions'
            local open_with_trouble = require('trouble.sources.telescope').open

            -- Use this to add more results without clearing the trouble list
            local add_to_trouble = require('trouble.sources.telescope').add

            -- [[ Configure Telescope ]]
            -- See `:help telescope` and `:help telescope.setup()`
            require('telescope').setup {
                -- You can put your default mappings / updates / etc. in here
                --  All the info you're looking for is in `:help telescope.setup()`
                --
                defaults = {
                    mappings = {
                        i = { ['<c-t>'] = open_with_trouble },
                        n = { ['<c-t>'] = open_with_trouble },
                    },
                    -- preview = {
                    --   mime_hook = function(filepath, bufnr, opts)
                    --     local is_image = function(fp) -- fp is filepath
                    --       local image_extensions = { 'png', 'jpg' } -- Supported image formats
                    --       local split_path = vim.split(fp:lower(), '.', { plain = true })
                    --       local extension = split_path[#split_path]
                    --       return vim.tbl_contains(image_extensions, extension)
                    --     end
                    --     if is_image(filepath) then
                    --       local term = vim.api.nvim_open_term(bufnr, {})
                    --       local function send_output(_, data, _)
                    --         for _, d in ipairs(data) do
                    --           vim.api.nvim_chan_send(term, d .. '\r\n')
                    --         end
                    --       end
                    --       -- TODO: make this work lmao
                    --       vim.fn.jobstart({
                    --         'feh',
                    --         filepath, -- Terminal image viewer command
                    --       }, { on_stdout = send_output, stdout_buffered = true, pty = true })
                    --     else
                    --       require('telescope.previewers.utils').set_preview_message(bufnr, opts.winid, 'Binary cannot be previewed')
                    --     end
                    --   end,
                    -- },
                },
                pickers = {
                    find_files = {
                        -- sort files by modified time (rg sorts result by modification date, fd don't)
                        find_command = { 'rg', '--files', '--hidden', '--sortr=modified', '--glob', '!.git', '--glob', '!node_modules' },
                    },
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            -- See `:help telescope.builtin`
            local builtin = require 'telescope.builtin' -- TODO: maybe seperate all telescope configs in one file?
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search: [h]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search: [k]eymaps' })
            vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = 'Search: [t]elescope Builtins' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search: By [g]rep' })
            vim.keymap.set({ 'n', 'x' }, '<leader>sw', builtin.grep_string, { desc = 'Search: Current [w]ord' })
            vim.keymap.set('n', '<leader>sG', function()
                builtin.live_grep {
                    find_command = {
                        'rg',
                        '--hidden',
                        '--glob',
                        '!.git',
                    },
                }
            end, { desc = 'Search: unfiltered [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search: [d]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search: [r]esume' })

            vim.keymap.set('n', '<leader>fe', function()
                builtin.find_files {
                    prompt_prefix = '   ',
                }
            end, { desc = 'Find [Local] R[e]cent Files' })

            vim.keymap.set('n', '<leader>fw', function()
                builtin.find_files {
                    cwd = vim.fn.expand '%:p:h',
                    prompt_prefix = '   ',
                }
            end, { desc = 'Find [Local] R[e]cent Files' })

            vim.keymap.set('n', '<leader>fb', function()
                builtin.buffers {
                    prompt_prefix = '   ',
                }
            end, { desc = 'Find [b]uffers' })

            vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Find [Global] [r]ecent Files' })

            vim.keymap.set('n', '<leader>fg', function()
                builtin.git_files {
                    prompt_prefix = '   ',
                }
            end, { desc = 'Find [g]it Files' })

            vim.keymap.set('n', '<leader>fd', function()
                local cwd = vim.fn.getcwd()
                builtin.find_files {
                    find_command = {
                        'fd',
                        '-tf',
                        '--hidden',
                        '--exclude',
                        '.git',
                        '--exclude',
                        '.obsidian',
                        '--exclude',
                        'node_modules',
                        '--search-path',
                        cwd,
                    },
                    prompt_prefix = '   ',
                }
            end, { desc = 'Fin[d] files' })

            -- Slightly advanced example of overriding default behavior and theme
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            -- It's also possible to pass additional configuration options.
            --  See `:help telescope.builtin.live_grep()` for information about particular keys
            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = 'Search: [/] in Open Files' })

            -- Shortcut for searching your Neovim configuration files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = 'Search: [n]eovim Files' })

            -- Telescope highlights
            vim.keymap.set('n', '<leader>uu', '<CMD>Telescope highlights<CR>', { desc = 'UI: highlights' })
        end,
    },
}
