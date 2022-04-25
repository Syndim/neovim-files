local api = vim.api

api.nvim_create_autocmd({ 'VimEnter', 'BufWinEnter', 'BufRead', 'BufNewFile' }, { pattern = { '*.arb' }, command = [[setlocal filetype=json]] })
