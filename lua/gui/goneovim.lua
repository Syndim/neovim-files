local g = vim.g

if not g.gonvim_running then
    return
end

local global = require("global")

if global.is_wsl then
    -- Neovide under wsl will fetch new set of environments and VIRTUAL_ENV
    -- environment variable somehow get lost
    -- So we reset it here
    local util = require("lspconfig/util")
    local path = util.path
    local cwd = vim.fn.getcwd()
    local match = vim.fn.glob(path.join(cwd, "poetry.lock"))
    if match ~= "" then
        local venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
        vim.env.VIRTUAL_ENV = venv
        vim.env.PATH = path.join(venv, "bin") .. ":" .. vim.env.PATH
    end

    local node_path = vim.fn.trim(vim.fn.system("mise where node"))
    vim.env.PATH = path.join(node_path, "bin") .. ":" .. vim.env.PATH
end
