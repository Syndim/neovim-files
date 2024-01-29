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
            vim.keymap.set('n', key, 'gcc', { remap = true })
            vim.keymap.set('v', key, 'gc', { remap = true })
        end
    end
end

return M
