local M = {}

function M.config()
    require('Comment').setup()

    local mapping_keys = {
        '<C-G>', -- For windows termianal
        '<C-H>', -- For Others
    }

    for _, key in ipairs(mapping_keys) do
        vim.api.nvim_set_keymap('n', key, 'gcc', {})
        vim.api.nvim_set_keymap('v', key, 'gc', {})
    end
end

return M
