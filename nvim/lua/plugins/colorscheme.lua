-- You can easily change to a different colorscheme.
-- Change the name of the colorscheme plugin below, and then
-- change the command in the config to whatever the name of that colorscheme is.

-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        -- init = function()
        --   vim.cmd.colorscheme 'catppuccin'
        -- end,
        opts = {
            transparent_background = false,
            -- show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
            -- term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = false, -- dims the background color of inactive window
                shade = 'dark',
                percentage = 1,  -- percentage of the shade to apply to the inactive window
            },
            -- no_italic = false, -- Force no italic
            -- no_bold = false, -- Force no bold
            -- no_underline = false, -- Force no underline
            -- styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            --   comments = { 'italic' }, -- Change the style of comments
            --   conditionals = { 'italic' },
            --   loops = {},
            --   functions = {},
            --   keywords = {},
            --   strings = {},
            --   variables = {},
            --   numbers = {},
            --   booleans = {},
            --   properties = {},
            --   types = {},
            --   operators = {},
            --   -- miscs = {}, -- Uncomment to turn off hard-coded styles
            -- },

            -- NOTE: override colors here
            color_overrides = {
                all = {},
                latte = {
                    -- base = '#ff0000',
                    -- mantle = '#242424',
                    -- crust = '#474747',
                },
                frappe = {},
                macchiato = {},
                mocha = {},
            },

            -- NOTE: override highlight groups here
            highlight_overrides = {
                all = function(colors)
                    return {
                        -- NvimTreeNormal = { fg = colors.none },
                        -- CmpBorder = { fg = '#3e4145' },
                    }
                end,
                latte = function(latte)
                    return {
                        -- Normal = { fg = latte.base },
                    }
                end,
                frappe = function(frappe)
                    return {
                        -- ['@comment'] = { fg = frappe.surface2, style = { 'italic' } },
                    }
                end,
                macchiato = function(macchiato)
                    return {
                        -- LineNr = { fg = macchiato.overlay1 },
                    }
                end,
                mocha = function(mocha)
                    return {
                        -- Comment = { fg = mocha.flamingo },
                        -- Normal = { bg = '#050517' },
                    }
                end,
            },
        },
    },

    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_better_performance = 1
            -- Fonts
            vim.g.gruvbox_material_disable_italic_comment = 0
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_enable_bold = 1
            vim.g.gruvbox_material_transparent_background = 1
            -- Themes
            vim.g.gruvbox_material_foreground =
            'original'                                           -- "original", "mix", "material" (use "mix" if too bright)
            vim.g.gruvbox_material_background = 'hard'           -- "hard", "medium", "soft" (use "hard" if too bright)
            vim.g.gruvbox_material_ui_contrast =
            'high'                                               -- "low", "high" The contrast of line numbers, indent lines, etc.
            vim.g.gruvbox_material_float_style = 'dim'           -- "bright", "dim" Background of floating windows
            vim.g.gruvbox_material_statusline_style = 'original' -- "default", "mix", "original"
            -- vim.g.gruvbox_material_disable_terminal_colors = 1
            -- Custom highlights
            vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
            -- by default := transparent ? 'grey background' : 'bold'
            vim.g.gruvbox_material_current_word = 'grey background'

            -- vim.cmd.colorscheme("gruvbox-material") -- For highlights customizations go to lua/core/highlights
        end,
    },

    -- original gruvbox
    {
        'ellisonleao/gruvbox.nvim',
        priority = 1000,
        config = true,
        opts = {
            terminal_colors = true, -- add neovim terminal colors
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = false,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true,    -- invert background for search, diffs, statuslines and errors
            contrast = 'hard', -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = true,
        },
    },

    -- WARN: THIS IS A VERY HEAVILY CUSTOMIZED MONOKAI
    {
        'loctvl842/monokai-pro.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            transparent_background = true,
            terminal_colors = true,
            devicons = false, -- highlight the icons of `nvim-web-devicons`
            styles = {
                comment = { italic = true },
                keyword = { italic = true },       -- any other keyword
                type = { italic = true },          -- (preferred) int, long, char, etc
                storageclass = { italic = true },  -- static, register, volatile, etc
                structure = { italic = true },     -- struct, union, enum, etc
                parameter = { italic = true },     -- parameter pass in function
                annotation = { italic = true },
                tag_attribute = { italic = true }, -- attribute of tag in reactjs
            },
            filter = 'machine',                    -- classic | octagon | pro | machine | ristretto | spectrum
            -- Enable this will disable filter option
            day_night = {
                enable = false,            -- turn off by default
                day_filter = 'pro',        -- classic | octagon | pro | machine | ristretto | spectrum
                night_filter = 'spectrum', -- classic | octagon | pro | machine | ristretto | spectrum
            },
            inc_search = 'background',     -- underline | background
            background_clear = {
                -- "float_win",
                'toggleterm',
                'telescope',
                'which-key',
                -- 'renamer',
                'notify',
                -- "nvim-tree",
                'neo-tree',
                'bufferline', -- better used if background of `neo-tree` or `nvim-tree` is cleared
            },                -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
            plugins = {
                bufferline = {
                    underline_selected = false,
                    underline_visible = false,
                },
                indent_blankline = {
                    context_highlight = 'default', -- default | pro
                    context_start_underline = false,
                },
            },
            ---@param cs Colorscheme
            ---@param p ColorschemeOptions
            ---@param Config MonokaiProOptions
            ---@param hp Helper
            -- override = function(cs: Colorscheme, p: ColorschemeOptions, Config: MonokaiProOptions, hp: Helper) end,
            ---@param filter "classic" | "machine" | "octagon" | "pro" | "ristretto" | "spectrum"
            overridePalette = function(filter)
                return {
                    -- Background and text colors
                    dark2 = '#161b1e',      -- Deep background color (darkest)
                    dark1 = '#1d2528',      -- Slightly lighter background
                    background = '#273136', -- Main background color
                    text = '#fcffb8',       -- Primary text color
                    -- text = '#f2fffc',       -- Primary text color
                    accent1 = '#c24c5a',    -- Red accent (functions)
                    -- accent1 = '#ff6d7e',    -- Red accent (functions)
                    accent2 = '#ffb270',    -- Orange accent (parameter)
                    accent3 = '#f9cc6c',    -- Yellow accent (strings)
                    -- accent3 = '#fabd2f',    -- Yellow accent
                    -- accent4 = '#97e522',    -- Green accent
                    accent4 = '#a2e57b', -- Green accent
                    -- accent5 = '#83a598', -- Blue accent
                    -- accent5 = '#4aa4bf', -- Blue accent
                    accent5 = '#7cd5f1',
                    accent6 = '#baa0f8', -- Purple accent (for booleans,  etc.)
                    dimmed1 = '#b8bcb9', -- Light gray
                    dimmed2 = '#8b9798', -- Medium-light gray
                    dimmed3 = '#6b7678', -- Medium gray
                    dimmed4 = '#545f62', -- Medium-dark gray
                    dimmed5 = '#1e1e1e', -- Dark gray
                }
            end,
            override = function()
                return {
                    CursorLine = { bg = '#1d1e24' },
                    NormalFloat = { bg = 'NONE' },
                    FloatTitle = { bg = '#f9cc6c' },
                    FloatFooter = { bg = '#f9cc6c' },
                    FloatBorder = { fg = '#425157' },
                    Directory = { fg = '#f9cc6c' },

                    -- ['@lsp.type.namespace.go'] = { fg = '#743c93' },
                    -- ['@lsp.type.namespace.go'] = { fg = '#fcffb8' },
                    Function = { fg = '#ff6d7e' },
                    Todo = { fg = '#4aa4bf' },
                    yamlBlockMappingKey = { fg = '#c24c5a' },

                    MarkViewCode = { bg = '#141421' },
                    MarkViewInlineCode = { bg = '#141421' },

                    -- LazyNormal = { fg = '#909c9d', bg = '#222a2d' },
                    LazyNormal = { fg = '#f2fffc', bg = 'NONE' },
                    LazyButton = { bg = '#1d1e24' },

                    StatusLine = { bg = '#1d1e24' },

                    TelescopeNormal = { fg = '#f2fffc' },
                    TelescopeResultsNormal = { fg = '#f2fffc' },
                    TelescopeResultsFunction = { fg = '#f9cc6c', bg = '#1d1e24' },
                    TelescopeResultsTitle = { bg = '#f9cc6c' },
                    TelescopePromptTitle = { bg = '#f9cc6c' },
                    TelescopePreviewTitle = { bg = '#f9cc6c' },

                    GrappleTitle = { fg = '#f2fffc', bg = '#1d1e24' },
                    GrappleFooter = { fg = '#f2fffc', bg = '#1d1e24' },

                    lualine_a_normal = { bg = '#f9cc6c' },

                    ['@markup.raw.block.markdown'] = { bg = 'NONE' },
                    ['@markup.raw.markdown_inline'] = { bg = 'NONE' },

                    BufferLineBackground = { bg = 'NONE' },
                    BufferLineSeparator = { bg = 'NONE' },
                    BufferLineTab = { bg = 'NONE' },
                    BufferLineWarning = { bg = 'NONE' },
                    BufferLineError = { bg = 'NONE' },
                    BufferLinePick = { bg = 'NONE' },
                    BufferLineInfo = { bg = 'NONE' },
                    BufferLineHint = { bg = 'NONE' },
                    BufferLineModified = { bg = 'NONE' },
                    BufferLineCloseButton = { bg = 'NONE' },
                    BufferLineIndicator = { bg = 'NONE' },
                    BufferLineDuplicate = { bg = 'NONE' },

                    BufferLineDevIconGoModInactive = { bg = 'NONE' },
                    BufferLineDevIconEnvInactive = { bg = 'NONE' },
                    BufferLineDevIconGoInactive = { bg = 'NONE' },
                    BufferLineDevIconGoMod = { bg = 'NONE' },
                    BufferLineDevIconGo = { bg = 'NONE' },
                    BufferLineDevIconEnv = { bg = 'NONE' },

                    BufferLineBufferSelected = { bg = 'NONE' },
                    BufferLineModifiedIcon = { bg = 'NONE' },
                    BufferLineIndicatorSelected = { bg = 'NONE' },
                    BufferLineModifiedSelected = { bg = 'NONE' },
                    BufferLineBuffer = { bg = 'NONE' },

                    BufferLineDevIconLuaSelected = { bg = 'NONE' },
                    BufferLineDevIconDefaultSelected = { bg = 'NONE' },

                    BufferLineGroupLabel = { bg = 'NONE' },
                    BufferLineDevIconLua = { bg = 'NONE' },
                    BufferLineErrorDiagnostic = { bg = 'NONE' },
                    BufferLineInfoDiagnostic = { bg = 'NONE' },
                    BufferLineHintDiagnostic = { bg = 'NONE' },
                    BufferLineDevIconDefault = { bg = 'NONE' },
                    BufferLineTabSeparator = { bg = 'NONE' },
                    BufferLineWarningDiagnostic = { bg = 'NONE' },
                    BufferLineDevIconLuaInactive = { bg = 'NONE' },
                    BufferLineDevIconDefaultInactive = { bg = 'NONE' },

                    BufferLineHintVisible = { bg = 'NONE' },
                    BufferLineInfoVisible = { bg = 'NONE' },
                    BufferLinePickVisible = { bg = 'NONE' },
                    BufferLineErrorVisible = { bg = 'NONE' },
                    BufferLineBufferVisible = { bg = 'NONE' },
                    BufferLineNumbersVisible = { bg = 'NONE' },
                    BufferLineWarningVisible = { bg = 'NONE' },
                    BufferLineModifiedVisible = { bg = 'NONE' },
                    BufferLineDuplicateVisible = { bg = 'NONE' },
                    BufferLineIndicatorVisible = { bg = 'NONE' },
                    BufferLineSeparatorVisible = { bg = 'NONE' },
                    BufferLineDiagnosticVisible = { bg = 'NONE' },
                    BufferLineCloseButtonVisible = { bg = 'NONE' },
                    BufferLineHintDiagnosticVisible = { bg = 'NONE' },
                    BufferLineInfoDiagnosticVisible = { bg = 'NONE' },
                    BufferLineErrorDiagnosticVisible = { bg = 'NONE' },
                    BufferLineWarningDiagnosticVisible = { bg = 'NONE' },
                }
            end,
        },
    },

    -- Rose Pine
    {
        'rose-pine/neovim',
        lazy = false,
        name = 'rose-pine',
        opts = {
            variant = 'auto',      -- auto, main, moon, or dawn
            dark_variant = 'main', -- main, moon, or dawn
            dim_inactive_windows = false,
            extend_background_behind_borders = true,

            styles = {
                bold = true,
                italic = true,
                transparency = true,
            },

            groups = {
                border = 'muted',
                link = 'iris',
                panel = 'surface',

                error = 'love',
                hint = 'iris',
                info = 'foam',
                warn = 'gold',

                git_add = 'foam',
                git_change = 'rose',
                git_delete = 'love',
                git_dirty = 'rose',
                git_ignore = 'muted',
                git_merge = 'iris',
                git_rename = 'pine',
                git_stage = 'iris',
                git_text = 'rose',
                git_untracked = 'subtle',

                headings = {
                    h1 = 'iris',
                    h2 = 'foam',
                    h3 = 'rose',
                    h4 = 'gold',
                    h5 = 'pine',
                    h6 = 'foam',
                },
                -- Alternatively, set all headings at once.
                -- headings = "subtle",
            },

            -- highlight_groups = {
            --   -- Comment = { fg = "foam" },
            --   -- VertSplit = { fg = "muted", bg = "muted" },
            --   WhichKeyFloat = { bg = '#050517' },
            --   WhichKeyBorder = { bg = '#89b4fa' },
            --   LazyNormal = { bg = '#050517' },
            --   TroubleNormal = { bg = '' },
            --   -- htmlBold = { fg = "rose" },
            --   -- markdownBold = { fg = "rose" },
            --   -- NeoTreeNormal = { bg = "#050517" },
            --   -- StatusLine = { bg = "#050517" },
            --   -- lualine_a_insert = { bg = "#050517" },
            -- },
            --
            -- before_highlight = function(group, highlight, palette)
            --   -- Disable all undercurls (FIX: not working kekw)
            --   if highlight.undercurl then
            --     highlight.undercurl = false
            --   end
            --   --
            --   -- Change palette colour
            --   -- if highlight.fg == palette.pine then
            --   --     highlight.fg = palette.foam
            --   -- end
            -- end,
        },
    },
}
