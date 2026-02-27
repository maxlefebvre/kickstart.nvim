return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - adds better diffing
    'nvim-telescope/telescope.nvim', -- optional
  },
  config = true,
  keys = {
    { '<leader>gn', '<cmd>Neogit<cr>', desc = 'Neogit' },
  },
}
