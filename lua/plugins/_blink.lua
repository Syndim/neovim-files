local M = {}

function M.cmp_config()
    require("blink.cmp").setup({
        keymap = {
            preset = "enter",
            ["<C-f>"] = false,
            ["<C-b>"] = false,
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        },
        cmdline = {
            keymap = { preset = "super-tab" },
            completion = {
                menu = {
                    auto_show = true,
                },
            },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },
        sources = {
            default = function(ctx)
                if vim.bo.filetype == "DressingInput" then
                    return {}
                end

                local sources = { "lsp", "buffer", "snippets", "path" }

                if vim.bo.filetype == "toml" then
                    table.insert(sources, "crates")
                elseif vim.bo.filetype == "json" then
                    table.insert(sources, "npm")
                elseif vim.bo.filetype == "lua" then
                    table.insert(sources, "lazydev")
                end

                return sources
            end,
            providers = {
                lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
                crates = {
                    name = "crates",
                    module = "blink.compat.source",
                    score_offset = -3,
                },
                npm = {
                    name = "npm",
                    module = "blink.compat.source",
                    score_offset = -3,
                },
            },
        },
        completion = {
            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
            list = {
                selection = {
                    auto_insert = true,
                    preselect = true,
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
            menu = {
                draw = {
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    },
                },
            },
        },
        signature = {
            enabled = true,
        },
    })
end

function M.pair_config()
    require("blink.pairs").setup({
        mappings = {
            disabled_filetypes = {
                "text",
            },
        },
    })
end

return M
