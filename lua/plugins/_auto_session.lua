local M = {}

function M.config()
    vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
    require('auto-session').setup({
        pre_save_cmds = { 'NvimTreeClose' }
    })
end

return M
