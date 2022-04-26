local g = vim.g
local o = vim.o
if not g.neovide then
    return
end

g.neovide_remember_window_size = true

local global = require('global')
if global.is_wsl then
    o.guifont = 'FiraCode NF:h14'
end
