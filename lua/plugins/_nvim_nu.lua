local M = {}

function M.config()
    require("nu").setup({
        complete_cmd_names = false, -- requires https://github.com/jose-elias-alvarez/null-ls.nvim
    })

    require("nu.tree_sitter_config")
    require("tree-sitter-manager")._install_single("nu", true)
end

return M
