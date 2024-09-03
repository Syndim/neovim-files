local M = {}

function M.config()
    local actions = require('telescope.actions')
    require('telescope').setup({
        defaults = {
            mappings = {
                i = {
                    ['<C-j>'] = actions.move_selection_next,
                    ['<C-k>'] = actions.move_selection_previous,
                    ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
                    -- TODO: Enable this below in the future
                    -- ['<C-h>'] = actions.preview_scrolling_left,
                    -- ['<C-l>'] = actions.preview_scrolling_right,
                },
                n = {
                    ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
                }
            },
            layout_config = {
                -- Changing to bottom because `search.nvim` will add tab bar below
                -- https://github.com/FabianWirth/search.nvim/issues/4
                prompt_position = 'bottom'
            },
            sorting_strategy = 'ascending',
        }
    })

    local opts = {
        noremap = true
    }

    local builtin = require('telescope.builtin')
    local dropdown_theme = require('telescope.themes').get_dropdown({
        layout_config = {
            width = function(_, max_columns, _)
                return math.min(max_columns, 160)
            end,
            height = function(_, _, max_lines)
                return math.min(max_lines, 15)
            end
        }
    })

    M.builtin = builtin
    M.dropdown_theme = dropdown_theme

    -- opts.desc = 'Find files'
    -- vim.keymap.set('n', '<C-p>', function() builtin.find_files(dropdown_theme) end, opts)
    -- opts.desc = 'Live grep'
    -- vim.keymap.set('n', '<Leader>fg', function() builtin.live_grep(dropdown_theme) end, opts)
    -- opts.desc = 'Find buffers'
    -- vim.keymap.set('n', '<Leader>fb', function() builtin.buffers(dropdown_theme) end, opts)
    -- vim.keymap.set('n', '<A-o>', function() builtin.buffers(dropdown_theme) end, opts)
    -- opts.desc = 'Find help tags'
    -- vim.keymap.set('n', '<Leader>fh', function() builtin.help_tags(dropdown_theme) end, opts)
    opts.desc = 'Git status'
    vim.keymap.set('n', '<Leader>gs', function() builtin.git_status(dropdown_theme) end, opts)
    -- opts.desc = 'Git branches'
    -- vim.keymap.set('n', '<Leader>gb', function() builtin.git_branches(dropdown_theme) end, opts)
    -- opts.desc = 'Find keymaps'
    -- vim.keymap.set('n', '<Leader>km', function() builtin.keymaps(dropdown_theme) end, opts)
    -- opts.desc = 'Find commands'
    -- vim.keymap.set('n', '<Leader>cm', function() builtin.commands(dropdown_theme) end, opts)
    -- opts.desc = 'Jump list'
    -- vim.keymap.set('n', '<Leader>jl', function() builtin.jumplist(dropdown_theme) end, opts)
    -- vim.keymap.set('n', '<A-j>', function() builtin.jumplist(dropdown_theme) end, opts)
end

return M
