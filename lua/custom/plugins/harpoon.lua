return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {
      settings = {
        save_on_toggle = true,
        save_on_ui_close = true,
      },
    }

    -- Basic UI
    vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon: Mark File' })
    vim.keymap.set('n', '<leader>q', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon: Menu' })
    vim.keymap.set('n', '<leader>r', function() harpoon:list():remove() end, { desc = 'Harpoon: Remove Current File' })

    -- TODO: Maybe change this
    -- JUMPING: Since <leader>1-9 is taken, let's try Alt + Number
    vim.keymap.set('n', '<M-1>', function() harpoon:list():select(1) end)
    vim.keymap.set('n', '<M-2>', function() harpoon:list():select(2) end)
    vim.keymap.set('n', '<M-3>', function() harpoon:list():select(3) end)
    vim.keymap.set('n', '<M-4>', function() harpoon:list():select(4) end)
    vim.keymap.set('n', '<M-5>', function() harpoon:list():select(5) end)
    vim.keymap.set('n', '<M-6>', function() harpoon:list():select(6) end)
    vim.keymap.set('n', '<M-7>', function() harpoon:list():select(7) end)
    vim.keymap.set('n', '<M-8>', function() harpoon:list():select(8) end)
    vim.keymap.set('n', '<M-9>', function() harpoon:list():select(9) end)
  end,
}
