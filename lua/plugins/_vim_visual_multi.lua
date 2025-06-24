local M = {}

function M.setup()
    -- https://github.com/Saghen/blink.cmp/issues/406
    vim.g.VM_maps = {
        ["I Return"] = "<S-CR>",
    }
end

function M.config() end

return M
