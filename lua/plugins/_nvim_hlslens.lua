local M = {}
local api = vim.api

local opts = {
    noremap = true
}

local silent_opts = {
    noremap = true,
    silent = true
}

api.nvim_set_keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR> <Cmd>lua require('hlslens').start()<CR>]], silent_opts)
api.nvim_set_keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR> <Cmd>lua require('hlslens').start()<CR>]], silent_opts)
api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)

-- use : instead of <Cmd>
api.nvim_set_keymap('n', '<Leader>l', [[:noh<CR>]], silent_opts)

function M.config()
    require('hlslens').setup({
        calm_down = true,
        nearest_only = true,
        nearest_float_when = 'always'
    })


end

return M
