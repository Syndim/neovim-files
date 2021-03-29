local cmd = vim.cmd

-- Buffer navigation
cmd('noremap <C-left> <C-O>')
cmd('noremap <C-right> <C-I>')
cmd('noremap <Leader>b <C-O>')
cmd('noremap <Leader>n <C-I>')
cmd('noremap <C-i> :bp<CR>')
cmd('noremap <C-o> :bn<CR>')

-- Close buffer
cmd('noremap <Leader>c :bd<CR>')

-- Vmap for maintain Visual Mode after shifting > and <   
cmd('vmap < <gv')
cmd('vmap > >gv')
