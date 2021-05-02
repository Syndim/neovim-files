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

cmd('inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : v:lua.check_back_space() ? "<TAB>" : coc#refresh()')
cmd('inoremap <silent><expr> <S-TAB> pumvisible() ? "<C-P>" : "<C-H>"')

-- Use <c-space> to trigger completion.
cmd('inoremap <silent><expr> <C-Space> coc#refresh()')
