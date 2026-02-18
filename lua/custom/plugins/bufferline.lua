return {
  { -- Buffer line to make tab-like system
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers', -- This makes it show open files, not Neovim tabs
          separator_style = 'thin',
          always_show_bufferline = true,
          show_buffer_close_icons = true,
          show_close_icon = false,
          numbers = 'ordinal', -- Show number on tab
          show_duplicate_prefix = true, -- Shows parent folder if names are the same (i love index.js)
          hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' },
          },

          -- This ensures the bar shifts when NvimTree is open
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              text_align = 'left',
              separator = true,
            },
          },
        },
      }
    end,
  },
}
