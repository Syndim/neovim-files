local g = vim.g
local api = vim.api
if not g.neovide then
    return
end

g.neovide_remember_window_size = true

local global = require('global')

if global.is_mac then
    local opts = {
        noremap = true
    }
    api.nvim_set_keymap('n', '˙', '<C-w>h', opts)
    api.nvim_set_keymap('n', '∆', '<C-w>j', opts)
    api.nvim_set_keymap('n', '˚', '<C-w>k', opts)
    api.nvim_set_keymap('n', '¬', '<C-w>l', opts)
    api.nvim_set_keymap('n', 'π', '<cmd>lua require("illuminate").goto_prev_reference()<cr>', opts)
    api.nvim_set_keymap('n', '˜', '<cmd>lua require("illuminate").goto_next_reference()<cr>', opts)
    api.nvim_set_keymap('n', 'ø', '<cmd>Telescope buffers<cr>', opts)
elseif global.is_wsl then
    -- Neovide under wsl will fetch new set of environments and VIRTUAL_ENV
    -- environment variable somehow get lost
    -- So we reset it here
    local util = require('lspconfig/util')
    local path = util.path
    local cwd = vim.fn.getcwd()
    local match = vim.fn.glob(path.join(cwd, 'poetry.lock'))
    if match ~= '' then
        local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
        vim.env.VIRTUAL_ENV = venv
        vim.env.PATH = path.join(venv, 'bin') .. ':' .. vim.env.PATH
    end

    local node_path = vim.fn.trim(vim.fn.system('rtx where node'))
    vim.env.PATH = path.join(node_path, 'bin') .. ':' .. vim.env.PATH
end
