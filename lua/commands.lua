local features = require('features')
function _G.format_on_save()
    if features.format_on_save_enabled then
        vim.lsp.buf.format()
    end
end

vim.cmd [[autocmd BufWritePre * lua format_on_save()]]
