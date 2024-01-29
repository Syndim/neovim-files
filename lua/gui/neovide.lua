local g = vim.g
local api = vim.api
if not g.neovide then
    return
end

g.neovide_remember_window_size = true

local global = require('global')

api.nvim_create_autocmd({ 'UIEnter' }, {
    callback = function()
        if global.is_wsl and vim.g.neovide then
            vim.o.guifont = 'FiraCode Nerd Font Mono:h14'
        end
    end
})

if global.is_mac then
    local opts = {
        remap = false
    }
    vim.keymap.set('n', '˙', '<C-w>h', opts)
    vim.keymap.set('n', '∆', '<C-w>j', opts)
    vim.keymap.set('n', '˚', '<C-w>k', opts)
    vim.keymap.set('n', '¬', '<C-w>l', opts)
    vim.keymap.set('n', 'π', require("illuminate").goto_prev_reference, opts)
    vim.keymap.set('n', '˜', require("illuminate").goto_next_reference, opts)
    vim.keymap.set('n', 'ø', function() vim.cmd.Telescope('buffers') end, opts)
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

    local node_path = vim.fn.trim(vim.fn.system('mise where node'))
    vim.env.PATH = path.join(node_path, 'bin') .. ':' .. vim.env.PATH
end
