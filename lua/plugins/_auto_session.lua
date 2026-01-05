local M = {}

function M.config()
    vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos"
    require("auto-session").setup({
        pre_save_cmds = { "OutlineClose", "SnacksExplorerClose", "SpectreClose", "Neotree close" },
    })
end

return M
