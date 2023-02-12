local M = {}

function M.config()
    for _, config in pairs(require('nvim-treesitter.parsers').get_parser_configs()) do
        config.install_info.url = config.install_info.url:gsub('https://github.com/',
            'https://ghproxy.com/https://github.com/')
    end

    local treesitter_path = vim.fn.stdpath('data') .. '/treesitter'
    vim.opt.runtimepath:prepend(treesitter_path)

    require('nvim-treesitter.configs').setup {
        parser_install_dir = treesitter_path,
        highlight = {
            enable = true,
            disable = {
                'dart'
            }
        },
        indent = {
            enable = false,
            disable = {}
        },
        rainbow = {
            enable = true,
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        },
        ensure_installed = {
            'cpp',
            'c_sharp',
            'css',
            'dart',
            'java',
            'javascript',
            'json',
            'kotlin',
            'lua',
            'python',
            'regex',
            'ruby',
            'rust',
            'scss',
            'toml',
            'tsx',
            'typescript',
            'yaml',
            'fish',
            'vim',
            'help'
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = 'gnn',
                node_incremental = 'grn',
                scope_incremental = 'grc',
                node_decremental = 'grm',
            },
        },
    }

    local ft_to_parser = require('nvim-treesitter.parsers').filetype_to_parsername
    ft_to_parser.javascript = 'tsx'
    ft_to_parser['typescript.tsx'] = 'tsx'
end

return M
