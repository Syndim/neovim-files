local M = {}
local cmd = vim.cmd

cmd("noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR> <Cmd>lua require('hlslens').start()<CR>")
cmd("noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR> <Cmd>lua require('hlslens').start()<CR>")
cmd("noremap * *<Cmd>lua require('hlslens').start()<CR>")
cmd("noremap # #<Cmd>lua require('hlslens').start()<CR>")
cmd("noremap g* g*<Cmd>lua require('hlslens').start()<CR>")
cmd("noremap g# g#<Cmd>lua require('hlslens').start()<CR>")

-- use : instead of <Cmd>
cmd('nnoremap <silent> <leader>l :noh<CR>')

function M.config()
    require('hlslens').setup({
        calm_down = true,
        nearest_only = true,
        nearest_float_when = 'always'
    })


end

return M
