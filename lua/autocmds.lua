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
            local ft = require('guard.filetype')
            local guard_config = ft[vim.bo.filetype]
            if guard_config and guard_config.format then
                vim.cmd [[GuardFmt]]
            else
                vim.lsp.buf.format()
            end
        end
    end
})
