local M = {}

function M.setup(lsp_config, config)
    local util = require('lspconfig.util')
    local sourcekit_config = vim.tbl_deep_extend('force', config, {
        root_dir = function(filename, _)
            return util.root_pattern('buildServer.json')(filename)
                or util.root_pattern('*.xcodeproj', '*.xcworkspace')(filename)
                or util.find_git_ancestor(filename)
                or util.root_pattern('Package.swift')(filename)
        end,
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'swift' }
    })
    lsp_config.sourcekit.setup(sourcekit_config)
end

return M
