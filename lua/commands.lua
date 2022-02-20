vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
