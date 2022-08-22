local M = {}

function M.config()
    require('Comment').setup()
    local global = require('global')

    local mapping_keys = {
        '<C-H>',
        global.is_windows and '<C-T>' or nil,
    }

    for _, key in ipairs(mapping_keys) do
        if key ~= nil then
            vim.api.nvim_set_keymap('n', key, 'gcc', {})
            vim.api.nvim_set_keymap('v', key, 'gc', {})
        end
    end
end

return M
