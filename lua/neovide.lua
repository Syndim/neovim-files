if not vim.g.neovide then
    return
end

local global = require('global')
if global.is_wsl then
    vim.o.guifont = 'FiraCode NF:h14'
end
