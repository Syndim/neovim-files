local M = {}

function M.setup()
    local global = require("global")

    local cmp_download = require("blink.cmp.fuzzy.download")
    local downloader = require("blink.download.downloader")

    local function download_file(async, config, files, url, filename)
        url = string.gsub(url, "https://github.com", global.github.url)
        url = string.gsub(url, "https://raw.githubusercontent.com", global.github.raw_url)
        return async.task.new(function(resolve, reject)
            local args = { "curl" }

            -- Use https proxy if available
            if config.proxy.url ~= nil then
                vim.list_extend(args, { "--proxy", config.proxy.url })
            elseif config.proxy.from_env then
                local proxy_url = os.getenv("HTTPS_PROXY")
                if proxy_url ~= nil then
                    vim.list_extend(args, { "--proxy", proxy_url })
                end
            end

            vim.list_extend(args, config.extra_curl_args)
            vim.list_extend(args, {
                "--fail", -- Fail on 4xx/5xx
                "--location", -- Follow redirects
                "--silent", -- Don't show progress
                "--show-error", -- Show errors, even though we're using --silent
                "--create-dirs",
                "--output",
                files.lib_folder .. "/" .. filename,
                url,
            })

            vim.system(args, {}, function(out)
                if out.code ~= 0 then
                    reject("Failed to download " .. filename .. "for pre-built binaries: " .. out.stderr)
                else
                    resolve()
                end
            end)
        end)
    end

    local function cmp_download_file(url, filename)
        local download_config = require("blink.cmp.config").fuzzy.prebuilt_binaries
        local async = require("blink.cmp.lib.async")
        local files = require("blink.cmp.fuzzy.download.files")

        return download_file(async, download_config, files, url, filename)
    end

    local function downloader_download_file(files, url, filename)
        local async = require("blink.download.lib.async")
        local config = require("blink.download.config")
        return download_file(async, config, files, url, filename)
    end

    if global.github.has_proxy then
        cmp_download.download_file = cmp_download_file
        downloader.download_file = downloader_download_file
    end
end

function M.cmp_config()
    local features = require("features")
    require("blink.cmp").setup({
        keymap = {
            preset = "enter",
            ["<C-f>"] = {},
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
                if features.plugin.code_companion.enabled then
                    table.insert(sources, "codecompanion")
                end

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
    require("blink.pairs").setup({})
end

return M
