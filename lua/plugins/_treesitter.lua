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
        ensure_installed = {
            "cpp",
            "css",
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

    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
end

return M
