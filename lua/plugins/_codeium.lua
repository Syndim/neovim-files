local M = {}

function M.setup()
    vim.g.codeium_disable_bindings = 1
end

function M.config()
    vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    vim.keymap.set('i', '<M-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
    vim.keymap.set('i', '<M-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
    vim.keymap.set('i', '<c-]>', function() return vim.fn['codeium#Clear']() end, { expr = true })
end

return M
