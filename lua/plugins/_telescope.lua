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
                },
                n = {
                    ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
                }
            },
            layout_config = {
                horizontal = {
                    prompt_position = 'top'
                }
            },
            sorting_strategy = 'ascending',
        }
    })

    local api = vim.api
    local opts = {
        noremap = true
    }

    opts.desc = 'Find files'
    vim.keymap.set('n', '<C-p>', function() vim.cmd.Telescope('find_files') end, opts)
    opts.desc = 'Live grep'
    vim.keymap.set('n', '<Leader>fg', function() vim.cmd.Telescope('live_grep') end, opts)
    opts.desc = 'Find buffers'
    vim.keymap.set('n', '<Leader>fb', function() vim.cmd.Telescope('buffers') end, opts)
    opts.desc = 'Find buffers'
    vim.keymap.set('n', '<A-o>', function() vim.cmd.Telescope('buffers') end, opts)
    opts.desc = 'Find help tags'
    vim.keymap.set('n', '<Leader>fh', function() vim.cmd.Telescope('help_tags') end, opts)
    opts.desc = 'Git status'
    vim.keymap.set('n', '<Leader>gs', function() vim.cmd.Telescope('git_status') end, opts)
    opts.desc = 'Git branches'
    vim.keymap.set('n', '<Leader>gb', function() vim.cmd.Telescope('git_branches') end, opts)
    opts.desc = 'Find keymaps'
    vim.keymap.set('n', '<Leader>km', function() vim.cmd.Telescope('keymaps') end, opts)
    opts.desc = 'Find commands'
    vim.keymap.set('n', '<Leader>cm', function() vim.cmd.Telescope('commands') end, opts)
end

return M
