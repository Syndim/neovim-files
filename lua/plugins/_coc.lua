local g = vim.g
local cmd = vim.cmd
local fn = vim.fn

g.coc_global_extensions = {
    'coc-omnisharp',
    'coc-snippets',
    'coc-rust-analyzer',
    'coc-tsserver',
    'coc-python',
    'coc-json',
    'coc-highlight',
    'coc-eslint',
    'coc-actions',
    'coc-css',
    'coc-solargraph',
    'coc-prettier',
    'coc-clangd',
    'coc-vimlsp',
    'coc-yaml',
    'coc-sh',
    'coc-xml',
    'coc-cmake',
    'coc-lua',
}

-- Remap keys for gotos
cmd('nmap <silent> gd <Plug>(coc-definition)')
cmd('nmap <silent> gy <Plug>(coc-type-definition)')
cmd('nmap <silent> gi <Plug>(coc-implementation)')
cmd('nmap <silent> gr <Plug>(coc-references)')

-- Remap for rename current word
cmd('nmap <leader>rn <Plug>(coc-rename)')

-- Remap for format selected region
cmd('vmap <leader>f  <Plug>(coc-format-selected)')
cmd('nmap <leader>f  <Plug>(coc-format-selected)')

-- Remap for Code action and code lens action
cmd('nmap <leader>cl <Plug>(coc-codelens-action)')
cmd('nmap <leader>ca <Plug>(coc-codeaction)')

-- Apply AutoFix to problem on the current line.
cmd('nmap <leader>qf  <Plug>(coc-fix-current)')

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
-- Source: https://github.com/nanotee/nvim-lua-guide#vlua
function _G.check_back_space()
    local col = fn.col('.') - 1
    if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

function _G.show_documentation()
    if fn.index({'vim', 'help'}, g.filetype) >= 0 then
        cmd('h ' .. fn.expand('<cword>'))
    elseif fn['coc#rpc#ready']() then
        fn.CocActionAsync('doHover')
    else
        cmd('!' .. g.keywordprg .. ' ' .. fn.expand('<cword>'))
    end
end

cmd('inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : v:lua.check_back_space() ? "<TAB>" : coc#refresh()')
cmd('inoremap <silent><expr> <S-TAB> pumvisible() ? "<C-P>" : "<C-H>"')
cmd('nnoremap <silent> K :call v:lua.show_documentation()<CR>')

-- Use <c-space> to trigger completion.
cmd('inoremap <silent><expr> <C-Space> coc#refresh()')

-- Mappings for CoCList
-- Show all diagnostics.
cmd('nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>')
-- Manage extensions.
cmd('nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>')
-- Show commands.
cmd('nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>')
-- Find symbol of current document.
cmd('nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>')
-- Search workspace symbols.
cmd('nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>')
-- Do default action for next item.
cmd('nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>')
-- Do default action for previous item.
cmd('nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>')
-- Resume latest coc list.
cmd('nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>')
