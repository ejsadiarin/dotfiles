return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    lazy = true,
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[f]ormat',
      },
    },
    opts = {
      notify_on_error = true,
      notify_no_formatters = true,
      formatters = {
        ['markdown-toc'] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find '<!%-%- toc %-%->' then
                return true
              end
            end
          end,
        },
        ['markdownlint-cli2'] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == 'markdownlint'
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
        csharpier = {
          command = 'dotnet-csharpier',
          args = { '--write-stdout' },
        },
      },
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true, java = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          -- async = true,
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        ['lua'] = { 'stylua' },
        ['go'] = { 'goimports', 'gofumpt' },
        -- Conform can also run multiple formatters sequentially
        ['python'] = { 'isort', 'black' },
        ['cs'] = { 'csharpier' },
        -- You can use 'stop_after_first' to run the first available formatter from the list
        ['javascript'] = { 'prettierd', 'prettier', stop_after_first = true }, -- ['javascript'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['typescript'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['javascriptreact'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['typescriptreact'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['css'] = { 'prettierd', 'prettier' },
        ['html'] = { 'prettierd', 'prettier' },
        ['json'] = { 'prettierd', 'prettier' },
        ['yaml'] = { 'prettierd', 'prettier' },
        ['markdown'] = { 'markdown-toc' },
        ['markdown.mdx'] = { 'markdown-toc' },
        ['php'] = { 'php_cs_fixer' },
      },
    },
  },
}
