return {
  "nvim-treesitter/nvim-treesitter",
  disable = function(lang, buf)
    local max_filesize = 100 * 1024 -- 100kb
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      return true
    end
  end,
  opts = {
    autotag = {
      enable = true,
    },
  },
}
