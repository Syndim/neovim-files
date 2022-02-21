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

    local cmd = vim.cmd
    cmd('nnoremap <C-p> <cmd>Telescope find_files<cr>')
    cmd('nnoremap <leader>fg <cmd>Telescope live_grep<cr>')
    cmd('nnoremap <leader>fb <cmd>Telescope buffers<cr>')
    cmd('nnoremap <leader>fh <cmd>Telescope help_tags<cr>')
end

return M
