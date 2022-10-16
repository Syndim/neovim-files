function _G.format_on_save()
    if vim.g.format_on_save_enabled then
        vim.lsp.buf.format()
    end
end

vim.cmd [[autocmd BufWritePre * lua format_on_save()]]
