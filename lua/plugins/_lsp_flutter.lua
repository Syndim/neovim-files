local M = {}

function M.setup(lsp, config)
    local function on_attach(client, bufnr)
        lsp.create_on_attach()(client, bufnr)
        local opts = { noremap = true, silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>cl', '<cmd>Telescope flutter commands<CR>', opts)
    end

    local flutter_config = vim.tbl_deep_extend('force', config, {
        on_attach = on_attach,
        handlers = {
            ["$/progress"] = function() end
        },
        flags = {
            debounce_text_changes = 300,
        },
        color = {
            enabled = true,
        }
    })

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
        lsp = flutter_config
    })

    require("telescope").load_extension("flutter")
end

return M
