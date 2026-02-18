-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- H/L for Line Ends
vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'Go to start of line' })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { desc = 'Go to end of line' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<leader>rn', function()
  if vim.api.nvim_get_option_value('relativenumber', {}) then
    vim.opt.relativenumber = false
  else
    vim.opt.relativenumber = true
  end
end)

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Split management
vim.keymap.set('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = 'Split Window Vertically' })
vim.keymap.set('n', '<leader>wh', '<cmd>split<cr>', { desc = 'Split Window Horizontally' })
vim.keymap.set('n', '<leader>wx', '<cmd>close<cr>', { desc = 'Close Current Window' })
vim.keymap.set('n', '<leader>wo', '<cmd>only<cr>', { desc = 'Close All Other Windows' }) -- "Only" keep this one

-- Cycle to next buffer
vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next Tab' })
-- Cycle to previous buffer
vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev Tab' })
-- Select buffer by ordinal number
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, function() require('bufferline').go_to(i, true) end, { desc = '', silent = true })
end
-- Close the current buffer
vim.keymap.set('n', '<leader>x', '<cmd>bp|sp|bn|bd<cr>', { desc = 'Close Buffer' })

-- Toggle File Explorer
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle Explorer' })

-- Terminal Split Management
vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Toggle [T]erminal [H]orizontal' })
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', { desc = 'Toggle [T]erminal [V]ertical' })
vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Toggle [T]erminal [F]loating' })

-- TODO: Resize not working
-- Resize terminals
vim.keymap.set('n', '<C-w><Left>', ':resize -5<CR>i', { silent = true })
vim.keymap.set('n', '<C-w><Right>', ':resize +5<CR>', { silent = true })
vim.keymap.set('n', '<C-w><Up>', ':vertical resize -5<CR>', { silent = true })
vim.keymap.set('n', '<C-w><Down>', ':vertical resize -5<cr>', { silent = true })
-- Same in terminal mode
vim.keymap.set('t', '<C-w><Left>', ':resize -5<CR>i', { silent = true })
vim.keymap.set('t', '<C-w><Right>', ':resize +5<CR>', { silent = true })
vim.keymap.set('t', '<C-w><Up>', ':vertical resize -5<CR>', { silent = true })
vim.keymap.set('t', '<C-w><Down>', ':vertical resize -5<cr>', { silent = true })
--
-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- vim: ts=2 sts=2 sw=2 et
