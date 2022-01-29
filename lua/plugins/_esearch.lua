local g = vim.g
local cmd = vim.cmd
local fn = vim.fn

local esarch_config = {
    regex = 1,
    prefill = {'hlsearch', 'last', 'clipboard'},
    default_mappings = 0,
        win_map = {
        { 'n', '<c-j>', '<plug>(esearch-win-jump:filename:down)' },
        { 'n', '<c-k>', '<plug>(esearch-win-jump:filename:up)' },
        { 'n', '<cr>', '<plug>(esearch-win-open)' },
        { 'n', 'p', '<plug>(esearch-win-preview)' },
        { 'n', 't', '<plug>(esearch-win-tabopen)' },
        { 'n', 'r', '<plug>(esearch-win-reload)' },
        { 'n', 's', '<plug>(esearch-win-vsplit:reuse:stay)' }
    }
}

g.esearch = esarch_config

cmd('nmap <Leader>ff <plug>(operator-esearch-prefill)')
