local api = vim.api

local opts = {
    remap = false
}

-- Split
-- vim.keymap.set('n', '<Leader>h', vim.cmd.split, opts)
-- vim.keymap.set('n', '<Leader>v', vim.cmd.vsplit, opts)

-- Buffer navigation
vim.keymap.set('n', '<C-left>', '<C-O>', opts)
vim.keymap.set('n', '<C-right>', '<C-I>', opts)
vim.keymap.set('n', '<Leader>b', '<C-O>', opts)
vim.keymap.set('n', '<Leader>n', '<C-I>', opts)
-- Neovim 0.7 separates tab and c-i so we need to map both
-- vim.keymap.set('n', '<Tab>', ':bp<CR>', opts)
-- vim.keymap.set('n', '<C-I>', ':bp<CR>', opts)
-- vim.keymap.set('n', '<C-O>', ':bn<CR>', opts)

-- Close buffer
vim.keymap.set('n', '<Leader>x', ':Bdelete<CR>', { noremap = true, nowait = true })

-- Clear CRLF
-- vim.keymap.set('n', '<Leader>r', ':%s/\\r//g<CR>', {})

-- Copy/Paste/Cut
vim.keymap.set('n', 'YY', '"+y<CR>', opts)
vim.keymap.set('n', 'P', '"+gP<CR>', opts)
vim.keymap.set('n', 'XX', '"+x<CR>', opts)

-- Vmap for maintain Visual Mode after shifting > and <
vim.keymap.set('v', '<', '<gv', {})
vim.keymap.set('v', '>', '>gv', {})

-- use alt+hjkl to move between split/vsplit panels
vim.keymap.set('t', '<A-h>', '<C-\\><C-n><C-w>h', opts)
vim.keymap.set('t', '<A-j>', '<C-\\><C-n><C-w>j', opts)
vim.keymap.set('t', '<A-k>', '<C-\\><C-n><C-w>k', opts)
vim.keymap.set('t', '<A-l>', '<C-\\><C-n><C-w>l', opts)
vim.keymap.set('n', '<A-h>', '<C-w>h', opts)
vim.keymap.set('n', '<A-j>', '<C-w>j', opts)
vim.keymap.set('n', '<A-k>', '<C-w>k', opts)
vim.keymap.set('n', '<A-l>', '<C-w>l', opts)

-- Clear search highlights
opts.desc = 'Clear highlights'
vim.keymap.set('n', '<Leader>ch', vim.cmd.noh, opts)

-- Close all buffers
opts.desc = 'Close all buffers'
vim.keymap.set('n', '<Leader>X', ':%bd<CR>', opts)

vim.keymap.set('n', '<C-h>', 'gcc', { remap = true })
vim.keymap.set('v', '<C-h>', 'gc', { remap = true })
