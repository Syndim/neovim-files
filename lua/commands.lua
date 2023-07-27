local features = require('features')
function _G.format_on_save()
    if features.format_on_save_enabled then
        vim.cmd [[GuardFmt]]
    end
end

vim.cmd [[autocmd BufWritePre * lua format_on_save()]]
