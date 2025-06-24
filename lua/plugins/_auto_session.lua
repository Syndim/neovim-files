local M = {}

function M.config()
    vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal"
    require("auto-session").setup({
        pre_save_cmds = { "OutlineClose", "SnacksExplorerClose", "SpectreClose" },
    })
end

return M
