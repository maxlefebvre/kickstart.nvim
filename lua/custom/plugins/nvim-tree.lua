local function my_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc) return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true } end

  -- Navigation (The "Helix/Vim" way)
  vim.keymap.set('n', 'l', api.node.open.edit, opts 'Open/Expand')
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts 'Open')
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close Directory')
  vim.keymap.set('n', 'v', api.node.open.vertical, opts 'Open: Vertical Split')

  -- Searching
  vim.keymap.set('n', 'f', function() api.live_filter.start() end, opts 'Filter')

  vim.keymap.set('n', 'C', function()
    api.live_filter.clear()
    api.tree.collapse_all()
    api.tree.find_file() -- Focus back on current file
  end, opts 'Clear and Collapse')

  -- File Management (Logical Mnemonics)
  vim.keymap.set('n', 'a', api.fs.create, opts 'Create (File or Folder)')
  vim.keymap.set('n', 'r', api.fs.rename, opts 'Rename')
  vim.keymap.set('n', 'd', api.fs.remove, opts 'Delete')
  vim.keymap.set('n', 'x', api.fs.cut, opts 'Cut')
  vim.keymap.set('n', 'c', api.fs.copy.node, opts 'Copy')
  vim.keymap.set('n', 'p', api.fs.paste, opts 'Paste')

  -- Utility
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
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      view = {
        width = 30,
        side = 'left',
      },
      -- Disable italics here too if the theme tries it
      renderer = {
        root_folder_label = false,
        group_empty = true,
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
