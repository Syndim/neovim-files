local api = vim.api

-- Fix json indent issue
api.nvim_create_autocmd({ 'VimEnter', 'BufWinEnter', 'BufRead', 'BufNewFile', 'BufEnter' },
    {
        pattern = { '*.arb', '*.json' },
        callback = function()
            vim.cmd('set filetype=json')
            vim.g.indentLine_conceallevel = 0
        end
    })

api.nvim_create_autocmd({ 'BufLeave' }, {
    pattern = { '*.arb', '*.json' },
    callback = function()
        vim.g.indentLine_conceallevel = nil
    end
})

-- Format on save
api.nvim_create_autocmd({ 'BufWritePre' }, {
    callback = function()
        local features = require('features')
        if features.format_on_save_enabled then
            vim.lsp.buf.format()
        end
    end
})

api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
    callback = function()
        vim.o.tabstop = 2
        vim.o.shiftwidth = 2
    end
})

api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = { '*.slint' },
    callback = function()
        vim.o.filetype = 'slint'
    end
})
