local M = {}

local global = require('global')
local features = require('features')

function M.status()
    if features.copilot_enabled then
        return require('copilot_status').status_string()
    end

    return ''
end

function M.config()
    require('copilot').setup({
        panel = {
            auto_refresh = true
        },
        suggestion = {
            auto_trigger = true,
            keymap = {
                accept = '<C-f>',
                next = vim.g.neovide and global.is_mac and '‘' or nil,
                prev = vim.g.neovide and global.is_mac and '“' or nil,
            }
        }
    })
end

return M
