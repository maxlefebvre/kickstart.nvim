local function my_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc) return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true } end

  -- 1. Navigation (The "Helix/Vim" way)
  vim.keymap.set('n', 'l', api.node.open.edit, opts 'Open/Expand')
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts 'Open')
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close Directory')
  vim.keymap.set('n', 'v', api.node.open.vertical, opts 'Open: Vertical Split')

  -- 2. File Management (Logical Mnemonics)
  vim.keymap.set('n', 'a', api.fs.create, opts 'Create (File or Folder)')
  vim.keymap.set('n', 'r', api.fs.rename, opts 'Rename')
  vim.keymap.set('n', 'd', api.fs.remove, opts 'Delete')
  vim.keymap.set('n', 'x', api.fs.cut, opts 'Cut')
  vim.keymap.set('n', 'c', api.fs.copy.node, opts 'Copy')
  vim.keymap.set('n', 'p', api.fs.paste, opts 'Paste')

  -- 3. Utility
  vim.keymap.set('n', 'R', api.tree.reload, opts 'Refresh Tree')
  vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help Menu')
  vim.keymap.set('n', 'q', api.tree.close, opts 'Close Tree')
end
return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      on_attach = my_on_attach,
      view = {
        width = 30,
        side = 'left',
      },
      -- Disable italics here too if the theme tries it
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        highlight_opened_files = 'none',
        indent_markers = {
          enable = true,
        },
      },
      filters = {
        dotfiles = true,
      },
    }
  end,
}
