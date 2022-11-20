local api = vim.api

local opts = {
    noremap = true
}

-- Split
api.nvim_set_keymap('n', '<Leader>h', ':split<CR>', opts)
api.nvim_set_keymap('n', '<Leader>h', ':split<CR>', opts)
api.nvim_set_keymap('n', '<Leader>v', ':vsplit<CR>', opts)

-- Buffer navigation
api.nvim_set_keymap('n', '<C-left>', '<C-O>', opts)
api.nvim_set_keymap('n', '<C-right>', '<C-I>', opts)
api.nvim_set_keymap('n', '<Leader>b', '<C-O>', opts)
api.nvim_set_keymap('n', '<Leader>n', '<C-I>', opts)
-- Neovim 0.7 separates tab and c-i so we need to map both
api.nvim_set_keymap('n', '<Tab>', ':bp<CR>', opts)
api.nvim_set_keymap('n', '<C-I>', ':bp<CR>', opts)
api.nvim_set_keymap('n', '<C-O>', ':bn<CR>', opts)

-- Close buffer
api.nvim_set_keymap('n', '<Leader>x', ':Bdelete<CR>', { noremap = true, silent = true, nowait = true })

-- Clear CRLF
api.nvim_set_keymap('n', '<Leader>r', ':%s/\\r//g<CR>', {})

-- Copy/Paste/Cut
api.nvim_set_keymap('n', 'YY', '"+y<CR>', opts)
api.nvim_set_keymap('n', 'P', '"+gP<CR>', opts)
api.nvim_set_keymap('n', 'XX', '"+x<CR>', opts)

-- Vmap for maintain Visual Mode after shifting > and <
api.nvim_set_keymap('v', '<', '<gv', {})
api.nvim_set_keymap('v', '>', '>gv', {})

-- use alt+hjkl to move between split/vsplit panels
api.nvim_set_keymap('t', '<A-h>', '<C-\\><C-n><C-w>h', opts)
api.nvim_set_keymap('t', '<A-j>', '<C-\\><C-n><C-w>j', opts)
api.nvim_set_keymap('t', '<A-k>', '<C-\\><C-n><C-w>k', opts)
api.nvim_set_keymap('t', '<A-l>', '<C-\\><C-n><C-w>l', opts)
api.nvim_set_keymap('n', '<A-h>', '<C-w>h', opts)
api.nvim_set_keymap('n', '<A-j>', '<C-w>j', opts)
api.nvim_set_keymap('n', '<A-k>', '<C-w>k', opts)
api.nvim_set_keymap('n', '<A-l>', '<C-w>l', opts)

-- Clear search highlights
api.nvim_set_keymap('n', '<Leader>ch', ':noh<CR>', opts)

-- Close all buffers
api.nvim_set_keymap('n', '<Leader>X', ':%bd<CR>', opts)
