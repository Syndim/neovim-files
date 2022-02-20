vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[command LSPInstall lua require('plugins._lsp').install()]]
