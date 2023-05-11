local M = {}

local features = require('features')
local global = require('global')

function M.status()
    if features.codeium_enabled then
        return vim.fn['codeium#GetStatusString']()
    end

    return ''
end

function M.setup()
    vim.g.codeium_disable_bindings = 1
end

function M.config()
    vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    vim.keymap.set('i', '<M-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    vim.keymap.set('i', '<M-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    vim.keymap.set('i', '<c-]>', function() return vim.fn['codeium#Clear']() end, { expr = true })

    if vim.g.neovide and global.is_mac then
        vim.keymap.set('i', '‘', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
        vim.keymap.set('i', '“', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    end
end

return M
