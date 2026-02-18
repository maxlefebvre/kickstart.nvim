return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    config = function()
      local filetypes = {
        'bash',
        'c',
        'diff',
        'html',
        'css',
        'go',
        'javascript',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'rust',
        'typescript',
        'vim',
        'vimdoc',
      }
      require('nvim-treesitter').install(filetypes)

      -- Only attach Tree-sitter if a parser exists for the buffer's filetype
      vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function(args)
          -- Check if Neovim recognizes a tree-sitter language for this filetype
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          -- Only start if a language parser is actually found/installed
          if lang then pcall(vim.treesitter.start, args.buf) end
          -- This tells Neovim to use Tree-sitter for indentation logic
          -- vim.bo[args.buf].indentexpr = 'v:lua.vim.treesitter.indent()'
        end,
      })
      -- Use this if above gets glitchy - if you do then make sure filetypes are complete
      -- vim.api.nvim_create_autocmd('FileType', {
      --   pattern = filetypes,
      --   callback = function() vim.treesitter.start() end,
      -- })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
