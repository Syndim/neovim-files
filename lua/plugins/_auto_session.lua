local M = {}

function M.config()
    require('auto-session').setup({
        pre_save_cmds = { 'Neotree action=close' }
    })
end

return M
