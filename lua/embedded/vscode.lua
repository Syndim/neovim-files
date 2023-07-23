if not vim.g.vscode then
    return
end

local api = vim.api
local opts = {
    noremap = true
}
api.nvim_set_keymap('n', '<leader>x', '<cmd>lua vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")<CR>', opts)
api.nvim_set_keymap('n', '<leader>X', '<cmd>lua vim.fn.VSCodeNotify("workbench.action.closeAllEditors")<CR>', opts)
api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.fn.VSCodeNotify("editor.action.revealDeclaration")<CR>', opts)