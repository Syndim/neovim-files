local M = {}

-- Remember to put flutter's bin folder to PATH
function M.config()
    local lsp = require('plugins._lsp')

    function on_attach(client, bufnr)
        lsp.create_on_attach()(client, bufnr)
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>cl', '<cmd>Telescope flutter commands<CR>', opts)
    end

    require("flutter-tools").setup({
        ui = {
            -- the border type to use for all floating windows, the same options/formats
            -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
            border = 'single',
        },
        decorations = {
            statusline = {
                -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
                -- this will show the current version of the flutter app from the pubspec.yaml file
                app_version = false,
                -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
                -- this will show the currently running device if an application was started with a specific
                -- device
                device = true,
            }
        },
        lsp = {
            on_attach = on_attach,
            capabilities = lsp.get_capabilities()
        }
    })

    require("telescope").load_extension("flutter")
end

return M
