return {
  { -- Adds buffer info to bufferline, so we scope the "tabs" to the pane
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = { 'SmiteshP/nvim-navic', 'nvim-tree/nvim-web-devicons' },
    opts = {
      attach_navic = true,
      show_modified = true,

      exclude_filetypes = { 'toggleterm', 'gitcommit' },

      show_navic = true,
      include_buftypes = { '' },

      sections = {
        navic = {
          filter = function()
            local stuctural_kinds = {
              'Class',
              'Method',
              'Function',
              'Constructor',
              'Interface',
              'Module',
            }
            for _, k in ipairs(stuctural_kinds) do
              if kind == k then return true end
            end

            return false
          end,
        },
      },
    },
  },
}
