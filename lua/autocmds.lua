local api = vim.api

api.nvim_create_autocmd({ 'VimEnter', 'BufWinEnter', 'BufRead', 'BufNewFile', 'BufEnter' }, { pattern = { '*.arb' }, command = [[set filetype=json g:vim_json_conceal=0]] })
