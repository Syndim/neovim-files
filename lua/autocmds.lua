local api = vim.api

api.nvim_create_autocmd({ 'VimEnter', 'BufWinEnter', 'BufRead', 'BufNewFile', 'BufEnter' }, { pattern = { '*.arb' }, command = [[setlocal filetype=json conceallevel=0]] })
