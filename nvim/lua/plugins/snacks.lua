return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        notifier = {
            enabled = true,
            timeout = 3000,
            style = "fancy"
        },
        quickfile = { enabled = true },
        scratch = {
            enabled = true,
            ft = "markdown",
            icon = nil,
        },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
            notification = {
                wo = { wrap = true } -- Wrap notifications
            },
            scratch = {
                width = 70,
                height = 20,
                bo = { buftype = "", buflisted = false, bufhidden = "hide", swapfile = false },
                minimal = true,
                noautocmd = false,
                -- position = "right",
                zindex = 20,
                wo = { winhighlight = "NormalFloat:Normal" },
                border = "rounded",
                title_pos = "center",
                footer_pos = "center",
            }
        }
    },
    keys = {
        { "<leader>cs", function() Snacks.scratch() end,                 desc = "Spawn Scratch Buffer" },
        { "<leadercS",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
        { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
        { "<leader>bd", "<CMD>:bd<CR>",                                  desc = "Buffer: [d]elete" },
        -- { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Buffer: [d]elete" },
        { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
        { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
        { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
        { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
        { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
        { "<leader>cR", function() Snacks.rename() end,                  desc = "Rename File" },
        { '<leader>nh', function() Snacks.notifier.show_history() end,   desc = 'Notification [h]istory' },
        { "<leader>nd", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
        { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
        { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference" },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
        {
            "<leader>N",
            desc = "Neovim News",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.6,
                    border = "rounded",
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "yes",
                        statuscolumn = " ",
                        conceallevel = 3,
                    },
                })
            end,
        }
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                    "<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
            end,
        })

        -- Simple LSP Progress
        vim.api.nvim_create_autocmd("LspProgress", {
            ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
            callback = function(ev)
                local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                vim.notify(vim.lsp.status(), "info", {
                    id = "lsp_progress",
                    title = "LSP Progress",
                    opts = function(notif)
                        notif.icon = ev.data.params.value.kind == "end" and " "
                            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                    end,
                })
            end,
        })
    end,
}
