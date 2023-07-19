local features = require('features')
function _G.format_on_save()
    if features.format_on_save_enabled then
        -- https://github.com/nvimdev/guard.nvim/pull/16
        local guard_enabled_filetypes = {
            typescriptreact = true
        }

        if guard_enabled_filetypes[vim.bo.filetype] ~= nil then
            vim.cmd [[GuardFmt]]
        else
            vim.lsp.buf.format()
        end
    end
end

vim.cmd [[autocmd BufWritePre * lua format_on_save()]]
