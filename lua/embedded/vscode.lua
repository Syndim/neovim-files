if not vim.g.vscode then
    return
end

local opts = {
    remap = false
}
opts.desc = 'Close current editor'
vim.keymap.set('n', '<leader>x', function() vim.fn.VSCodeNotify("workbench.action.closeActiveEditor") end, opts)
opts.desc = 'Close all editors'
vim.keymap.set('n', '<leader>X', function() vim.fn.VSCodeNotify("workbench.action.closeAllEditors") end, opts)
opts.desc = 'Go to declaration'
vim.keymap.set('n', 'gr', function() vim.fn.VSCodeNotify("editor.action.revealDeclaration") end, opts)

