local M = {}

function M.setup(config)
    -- lsp_config['pylsp'].setup(config)

    -- Below config are for pyright
    local global = require("global")
    local Path = require("plenary.path")
    -- print(vim.env.VIRTUAL_ENV)

    local function update_venv_path(venv)
        vim.env.VIRTUAL_ENV = venv
        local venv_path = Path:new(venv)
        if global.is_windows then
            vim.env.PATH = tostring(venv_path / "Scripts") .. ";" .. vim.env.PATH
        else
            vim.env.PATH = tostring(venv_path / "bin") .. ":" .. vim.env.PATH
        end
    end

    local function format_python_path(venv)
        local venv_path = Path:new(venv)
        if global.is_windows then
            return tostring(venv_path / "Scripts" / "python")
        else
            return tostring(venv_path / "bin" / "python")
        end
    end

    local function get_git_root(workspace)
        local result = vim.fn.system({ "git", "-C", workspace, "rev-parse", "--show-toplevel" })
        if vim.v.shell_error ~= 0 then
            return nil
        end

        return vim.fn.trim(result)
    end

    local function get_python_path(workspace)
        -- Use activated virtualenv.
        if vim.env.VIRTUAL_ENV then
            update_venv_path(vim.env.VIRTUAL_ENV)
            return format_python_path(vim.env.VIRTUAL_ENV)
        end

        -- Find .venv folder. The workspace root (e.g. a package inside a
        -- monorepo such as Monty) may not be the git root, so search the
        -- package root first, then fall back to the git root.
        local search_roots = { workspace }
        local git_root = get_git_root(workspace)
        if git_root and git_root ~= workspace then
            table.insert(search_roots, git_root)
        end

        for _, root in ipairs(search_roots) do
            local dot_venv_path = tostring(Path:new(root) / ".venv")
            if vim.fn.isdirectory(dot_venv_path) == 1 then
                update_venv_path(dot_venv_path)
                return format_python_path(dot_venv_path)
            end
        end

        -- Fallback to system Python.
        return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
    end

    local python_config = vim.tbl_deep_extend("force", config, {
        on_init = function(client)
            client.config.settings = client.config.settings or {}
            client.config.settings.python = client.config.settings.python or {}
            client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
        end,
        on_attach = function(client, bufnr)
            config.on_attach(client, bufnr)
            if client.name == "ruff" then
                -- Disable hover in favor of Pyright
                client.server_capabilities.hoverProvider = false
            end
        end,
    })

    -- vim.lsp.config("basedpyright", python_config)
    vim.lsp.config("ty", python_config)
    vim.lsp.config("ruff", python_config)
    -- vim.lsp.enable("basedpyright")
    vim.lsp.enable("ruff")
    vim.lsp.enable("ty")
end

return M
