return {
  'nvim-telescope/telescope.nvim', 
  dependencies = { 
    { 'nvim-lua/plenary.nvim' }
  },
  tag = '0.1.8',
  opts = {
    layout_strategy = 'vertical',
    pickers = {
      find_files = {
        file_ignore_patterns = { 'node_modules', '.git' },
        hidden = true,
      },
      live_grep = {
        file_ignore_patterns = { 'node_modules', '.git' },
        hidden = true,
      },
    },

  },
  keys = {
    {
      '<leader>ff',
      '<cmd>Telescope find_files theme=dropdown<cr>',
      desc = 'Find Files'
    },
    {
      '<leader>fg',
      '<cmd>Telescope live_grep theme=dropdown<cr>',
      desc = 'Find Files'
    },
    {
      '<leader>fh',
      '<cmd>Telescope help_tags theme=dropdown<cr>',
      desc = 'Find Files'
    },
  }
}
