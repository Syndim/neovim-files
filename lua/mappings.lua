local cmd = vim.cmd

-- Buffer navigation
cmd([[noremap <C-left> <C-O>]])
cmd([[noremap <C-right> <C-I>]])
cmd([[noremap <Leader>b <C-O>]])
cmd([[noremap <Leader>n <C-I>]])
cmd([[noremap <C-i> :bp<CR>]])
cmd([[noremap <C-o> :bn<CR>]])

-- Close buffer
cmd([[nnoremap <silent><nowait> <Leader>x :Bdelete<CR>]])

-- Clear CRLF
cmd([[nmap <leader>r :%s/\r//g<CR>]])

-- Copy/Paste/Cut
cmd([[noremap YY "+y<CR>]])
cmd([[noremap P "+gP<CR>]])
cmd([[noremap XX "+x<CR>]])

-- Vmap for maintain Visual Mode after shifting > and <
cmd([[vmap < <gv]])
cmd([[vmap > >gv]])

-- use alt+hjkl to move between split/vsplit panels
cmd([[tnoremap <A-h> <C-\><C-n><C-w>h]])
cmd([[tnoremap <A-j> <C-\><C-n><C-w>j]])
cmd([[tnoremap <A-k> <C-\><C-n><C-w>k]])
cmd([[tnoremap <A-l> <C-\><C-n><C-w>l]])
cmd([[nnoremap <A-h> <C-w>h]])
cmd([[nnoremap <A-j> <C-w>j]])
cmd([[nnoremap <A-k> <C-w>k]])
cmd([[nnoremap <A-l> <C-w>l]])
