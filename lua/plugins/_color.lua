local M = {}

function M.config()
    -- workaround for colorscheme: https://github.com/wbthomason/packer.nvim/issues/554
    vim.o.runtimepath = vim.o.runtimepath .. "," .. vim.fn.stdpath('data') .. '/site/pack/packer/start/onehalf/vim'
    vim.cmd('colorscheme onehalfdark')
end

return M
