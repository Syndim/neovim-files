local cmd = vim.cmd

cmd('nnoremap <silent> <F2> :NERDTreeFind<CR>')
cmd('noremap <F3> :NERDTreeToggle<CR>')

-- prevent other buffers replacing NERDTree in its window
-- cmd([[autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif]])
