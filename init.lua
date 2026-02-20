--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
-- See `:help mapleader`

-- Set <space> as the leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--  Separate init for vscode
if vim.g.vscode then
  -- Options for vscode
  vim.opt.clipboard = 'unnamedplus'
  vim.opt.shortmess:append 's'
  vim.opt.cmdheight = 0
  require 'lazy-bootstrap'

  require('lazy').setup {
    -- Plugins compatible with vscode
    require 'kickstart.plugins.mini',
  }
  -- Keymaps

  -- Use the vscode equivalents for my telescope setup
  vim.keymap.set('n', '<leader>sf', [[<cmd> call VSCodeNotify('workbench.action.quickOpen')<CR>]])
  vim.keymap.set('n', '<leader>sa', [[<cmd> call VSCodeNotify('workbench.action.findInFiles')]<CR>]])
  vim.keymap.set('n', '<leader>ss', function() vim.fn.VSCodeNotify('workbench.action.findInFiles', { filesToExclude = '**/*test*' }) end)
  vim.keymap.set('n', '<leader>st', function() vim.fn.VSCodeNotify('workbench.action.findInFiles', { filesToInclude = '**/*test*' }) end)

  vim.keymap.set('n', '<leader>f', [[<cmd> call VSCodeNotify('editor.action.formatDocument')<CR>]])
  -- Switch tabs
  for i = 1, 9 do
    vim.keymap.set('n', '<leader>' .. i, function() vim.fn.VSCodeNotify('workbench.action.openEditorAtIndex' .. i) end)
  end

  -- H/L for Line Ends
  vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'Go to start of line' })
  vim.keymap.set({ 'n', 'v' }, 'L', '$', { desc = 'Go to end of line' })

  -- Pane navigation
  vim.keymap.set('n', '<C-h>', [[<cmd> call VSCodeNotify('workbench.action.navigateLeft')<CR>]])
  vim.keymap.set('n', '<C-l>', [[<cmd> call VSCodeNotify(workbench.action.navigateRight')<CR>]])
  vim.keymap.set('n', '<C-j>', [[<cmd> call VSCodeNotify(workbench.action.navigateDown')<CR>]])
  vim.keymap.set('n', '<C-k>', [[<cmd> call VSCodeNotify(workbench.action.navigateUp')<CR>]])

  -- Windows/panes
  vim.keymap.set('n', '<leader>wv', [[<cmd> call VSCodeNotify('workbench.action.splitEditor')<CR>]], { desc = 'Split Window Vertically' })
  vim.keymap.set('n', '<leader>wh', [[<cmd> call VSCodeNotify('workbench.action.splitEditorDown')<CR>]], { desc = 'Split Window Horizontally' })
  vim.keymap.set('n', '<leader>wx', [[<cmd> call VSCodeNotify('workbench.action.closeActiveEditor')<CR>]], { desc = 'Close Current Window' })

  return
end

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

require 'autocmds'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- [[ Add custom snippets via luasnip ]]
require 'snippets'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
