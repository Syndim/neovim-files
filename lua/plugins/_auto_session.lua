local M = {}

function M.config()
    require('auto-session').setup({
        pre_save_cmds = { 'NvimTreeClose' }
    })
end

return M
