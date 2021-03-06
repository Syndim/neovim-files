local M = {}

function M.config()
    local actions = require('telescope.actions')
    require('telescope').setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
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

    api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<cr>', opts)
    api.nvim_set_keymap('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>', opts)
    api.nvim_set_keymap('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', opts)
    api.nvim_set_keymap('n', '<Leader>fh', '<cmd>Telescope help_tags<cr>', opts)
end

return M
