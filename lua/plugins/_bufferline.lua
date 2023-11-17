local M = {}

function M.config()
    local bufferline = require('bufferline')
    bufferline.setup(
        {
            options = {
                show_buffer_close_icons = false,
                show_close_icon = false,
                left_trunc_marker = '',
                right_trunc_marker = '',
                separator_style = 'thin',
                diagnostics = 'nvim_lsp',
                offsets = {
                    { filetype = 'NvimTree', text = 'File Explorer', text_align = 'left' }
                },
                style_preset = {
                    bufferline.style_preset.no_italic
                }
            }
        }
    )

    local opts = {
        noremap = true
    }

    vim.api.nvim_set_keymap('n', '<C-I>', ':BufferLineCyclePrev<CR>', opts)
    vim.api.nvim_set_keymap('n', '<C-O>', ':BufferLineCycleNext<CR>', opts)
end

return M
