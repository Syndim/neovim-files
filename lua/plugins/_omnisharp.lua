local g = vim.g
local cmd = vim.cmd
local fn = vim.fn

g.OmniSharp_selector_ui = 'fzf'
g.OmniSharp_selector_findusages = 'fzf'

function _G.format_callback()
    cmd('noautocmd write')
    cmd('set nomodified')
end

cmd('autocmd CursorHold *.cs OmniSharpTypeLookup')
cmd('autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)')
cmd('autocmd FileType cs nmap <silent> <buffer> gr <Plug>(omnisharp_find_usages)')
cmd('autocmd FileType cs nmap <silent> <buffer> gi <Plug>(omnisharp_find_implementations)')
cmd('autocmd FileType cs nmap <silent> <buffer> K <Plug>(omnisharp_documentation)')
cmd('autocmd FileType cs nmap <silent> <buffer> <space>s <Plug>(omnisharp_find_symbol)')
cmd('autocmd FileType cs nmap <silent> <buffer> <Leader>pd <Plug>(omnisharp_preview_definition)')
cmd('autocmd FileType cs nmap <silent> <buffer> <C-\\> <Plug>(omnisharp_signature_help)')
cmd('autocmd FileType cs imap <silent> <buffer> <C-\\> <Plug>(omnisharp_signature_help)')
cmd('autocmd FileType cs nmap <silent> <buffer> <Leader>rn <Plug>(omnisharp_rename)')
cmd('autocmd FileType cs nmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)')
cmd('autocmd FileType cs xmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)')
cmd('autocmd BufWritePre *.cs call OmniSharp#actions#format#Format({->execute(\'noau w\')})')
