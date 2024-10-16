return {
  {
    'cbochs/grapple.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    opts = {
      scope = 'git',
      statusline = {
        icon = '󰛢',
        active = '|%s|',
        inactive = ' %s ',
      },
    },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = 'Grapple',
    keys = {
      { '<leader>a', '<cmd>Grapple toggle<cr>', desc = 'Grapple: toggle tag' },
      { '<leader>h', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple: open tags window' },
      { '<S-l>', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple cycle next tag' },
      { '<S-h>', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple cycle previous tag' },
      { '<leader>1', '<cmd>Grapple select index=1<cr>', desc = 'which_key_ignore' },
      { '<leader>2', '<cmd>Grapple select index=2<cr>', desc = 'which_key_ignore' },
      { '<leader>3', '<cmd>Grapple select index=3<cr>', desc = 'which_key_ignore' },
      { '<leader>4', '<cmd>Grapple select index=4<cr>', desc = 'which_key_ignore' },
    },
  },
}
