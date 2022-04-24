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
            "just",
            "nu"
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

    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
end

return M
