local M = {}

function M.config()
    local builtin = require('telescope.builtin')
    local search = require('search');
    local dropdown_theme = require('plugins._telescope').dropdown_theme
    search.setup({
        mappings = { -- optional: configure the mappings for switching tabs (will be set in normal and insert mode(!))
            next = '<C-L>',
            prev = '<C-H>'
        },
        tabs = {
            {
                'Files',
                function()
                    builtin.find_files(dropdown_theme)
                end
            },
            {
                'Buffers',
                function()
                    builtin.buffers(dropdown_theme)
                end
            },
            {
                'Grep',
                function()
                    builtin.live_grep(dropdown_theme)
                end
            },
            {
                'Help',
                function()
                    builtin.help_tags(dropdown_theme)
                end
            },
            {
                'Branches',
                function()
                    builtin.git_branches(dropdown_theme)
                end
            },
            {
                'Keymaps',
                function()
                    builtin.keymaps(dropdown_theme)
                end
            },
            {
                'Commands',
                function()
                    builtin.commands(dropdown_theme)
                end
            }
        },
    })
    local opts = {
        noremap = true
    }
    opts.desc = 'Find files'
    vim.keymap.set('n', '<C-p>', search.open, opts)
    opts.desc = 'Live grep'
    vim.keymap.set('n', '<Leader>fg', function() search.open({ tab_name = 'Grep' }) end, opts)
    opts.desc = 'Find buffers'
    vim.keymap.set('n', '<Leader>fb', function() search.open({ tab_name = 'Buffers' }) end, opts)
    opts.desc = 'Find buffers'
    vim.keymap.set('n', '<A-o>', function() search.open({ tab_name = 'Buffers' }) end, opts)
    opts.desc = 'Find help tags'
    vim.keymap.set('n', '<Leader>fh', function() search.open({ tab_name = 'Help' }) end, opts)
    opts.desc = 'Git branches'
    vim.keymap.set('n', '<Leader>gb', function() search.open({ tab_name = 'Branches' }) end, opts)
    opts.desc = 'Find keymaps'
    vim.keymap.set('n', '<Leader>km', function() search.open({ tab_name = 'Keymaps' }) end, opts)
    opts.desc = 'Find commands'
    vim.keymap.set('n', '<Leader>cm', function() search.open({ tab_name = 'Commands' }) end, opts)
end

return M
