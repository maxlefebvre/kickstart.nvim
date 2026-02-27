-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-dap.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is ostart by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`

      local actions = require 'telescope.actions'
      local telescope = require 'telescope'
      local lga_actions = require 'telescope-live-grep-args.actions'

      telescope.setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          mappings = {
            i = {
              -- Enter opens the file here
              ['<CR>'] = actions.select_default,
              -- Open existing file, basically searches for open buffers
              -- and moves there if it's already open
              ['<C-o>'] = actions.select_drop,
              -- Standard split mapping
              ['<C-v>'] = actions.select_vertical,
              ['<C-h>'] = actions.select_horizontal,
            },
          },
        },
        pickers = {
          find_files = {
            follow = true, -- Follow sym links
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
          live_grep_args = {
            auto_quoting = true, -- TODO: Not sure if I want this yet
            mappings = {
              i = {
                ['<C-k>'] = lga_actions.quote_prompt(),
                ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
              },
            },
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
      pcall(telescope.load_extension, 'dap')
      pcall(telescope.load_extension 'live_grep_args')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      -- Utility
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sb', builtin.builtin, { desc = '[S]earch [B]uilt-in' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })

      -- File searches
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set(
        'n',
        '<leader>sF',
        function()
          require('telescope.builtin').find_files {
            prompt_title = 'Find Files (include hidden)',
            find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix', '--hidden', '--exclude', '.git' },
          }
        end,
        { desc = '[S]earch [F]iles (with Hidden)' }
      )

      -- Grep searches
      vim.keymap.set('n', '<leader>sg', function() telescope.extensions.live_grep_args.live_grep_args() end, { desc = '[S]earch [G]rep (Args)' })
      vim.keymap.set(
        'n',
        '<leader>sa',
        function()
          builtin.live_grep {
            prompt_title = 'Seach All (Grep)',
          }
        end,
        { desc = '[S]earch by [A]ll' }
      )
      vim.keymap.set('n', '<leader>ss', function()
        builtin.live_grep {
          prompt_title = 'Seach Sources (Grep)',
          additional_args = function() return { '--glob', '!**/*test*/**' } end, -- If I still got results, consider adding '!**/*test*' but this will catch things like latest-results.json
        }
      end, { desc = '[S]earch [S]ource' })
      vim.keymap.set('n', '<leader>st', function()
        builtin.live_grep {
          prompt_title = 'Seach Tests (Grep)',
          additional_args = function() return { '--glob', '**/*test*/**' } end,
        }
      end, { desc = '[S]earch [T]ests' })

      -- Search current buffer
      vim.keymap.set(
        'n',
        '<leader>/',
        function()
          builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        { desc = '[/] Fuzzily search in current buffer' }
      )

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set(
        'n',
        '<leader>s/',
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        { desc = '[S]earch [/] in Open Files' }
      )

      -- Custom Pickers
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      -- Harpoon search
      vim.keymap.set('n', '<leader>sh', function() toggle_telescope(require('harpoon'):list()) end, { desc = 'Search Harpoon Marks' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
