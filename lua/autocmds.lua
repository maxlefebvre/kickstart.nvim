return {
  -- Force-kill italics on the selected tab whenever the theme loads
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('UserHighlights', { clear = true }),
    desc = 'Remove italics from tabs',
    callback = function() vim.api.nvim_set_hl(0, 'BufferLineBufferSelected', { italic = false, bold = true }) end,
  }),

  -- Run it immediately so you don't have to restart to see the change
  vim.cmd 'doautocmd ColorScheme',
}
