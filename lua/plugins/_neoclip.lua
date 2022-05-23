local M = {}

function M.config()
    require('neoclip').setup({
        keys = {
            telescope = {
                i = {
                    paste = '<nop>',
                    paste_behind = '<nop>'
                }
            }
        }
    })
    require('telescope').load_extension('neoclip')
    vim.api.nvim_set_keymap('n', '<leader>p', [[<cmd>Telescope neoclip<CR>]], { noremap = true })
end

return M
