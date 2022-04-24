local M = {}

function M.config()
    require 'nvim-treesitter.configs'.setup {
        highlight = {
            enable = true,
            disable = {}
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
            "cpp",
            "c_sharp",
            "css",
            "dart",
            "java",
            "javascript",
            "json",
            "kotlin",
            "lua",
            "python",
            "regex",
            "ruby",
            "rust",
            "scss",
            "toml",
            "tsx",
            "typescript",
            "yaml",
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
    }

    local ft_to_parser = require "nvim-treesitter.parsers".filetype_to_parsername
    ft_to_parser.javascript = 'tsx'
    ft_to_parser['typescript.tsx'] = 'tsx'
end

return M
