local features = require('features')
function _G.format_on_save()
    if features.format_on_save_enabled then
        local ft = require('guard.filetype')
        local guard_config = ft[vim.bo.filetype]
        if guard_config and guard_config.format then
            vim.cmd [[GuardFmt]]
        else
            vim.lsp.buf.format()
        end
    end
end

vim.cmd [[autocmd BufWritePre * lua format_on_save()]]
