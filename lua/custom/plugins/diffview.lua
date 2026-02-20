return {
  'sindrets/diffview.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    { '<leader>Dd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview: Open Staged' },
    {
      '<leader>Db',
      function()
        local branch = vim.fn.systemlist('git rev-parse --abbrev-ref HEAD')[1]
        if branch then vim.cmd('DiffviewOpen origin/' .. branch) end
      end,
      desc = 'Diffview: Open vs origin/<branch>',
    },
    { '<leader>Dm', '<cmd>DiffviewOpen master<cr>', desc = 'Diffview: Open vs master' },
    { '<leader>DM', '<cmd>DiffviewOpen main<cr>', desc = 'Diffview: Open vs main' },
    {
      '<leader>Dp',
      function()
        local branch = vim.fn.input('Compare with; ', 'master')
        if branch ~= '' then vim.cmd('DiffviewOpen ' .. branch) end
      end,
      desc = 'Diffview: Prompt Branch',
    },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = { layout = 'diff2_horizontal' },
    },
    keymaps = {
      view = {
        -- Press 'q' while looking at diffs to close out
        { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } },
      },
      file_panel = {
        -- Press 'q' while in diff 'file' panel to close out
        { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } },
      },
    },
    hooks = {
      -- Hookt o close NvimTree automatiicaly since the diff split will take the screen
      diff_view_opened = function()
        local nvim_tree_view = require 'nvim-tree.view'
        if nvim_tree_view.is_visible() then vim.cmd 'NvimTreeClose' end
      end,
    },
  },
}
