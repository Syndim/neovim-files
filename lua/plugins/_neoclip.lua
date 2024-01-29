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
    local opts = { remap = false }
    opts.desc = 'Open neoclip'
    vim.keymap.set('n', '<leader>p', function() vim.cmd.Telescope('neoclip') end, opts)
end

return M
