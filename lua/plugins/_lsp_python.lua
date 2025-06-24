local M = {}

function M.setup(lsp_config, config)
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

    local function get_python_path(workspace)
        -- Use activated virtualenv.
        if vim.env.VIRTUAL_ENV then
            update_venv_path(vim.env.VIRTUAL_ENV)
            return format_python_path(vim.env.VIRTUAL_ENV)
        end

        local workspace_path = Path:new(workspace)

        -- Find and use venv from poetry
        -- local match = vim.fn.glob(tostring(workspace_path / "poetry.lock"))
        -- if match ~= "" then
        -- 	local venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
        -- 	update_venv_path(venv)
        -- 	return format_python_path(venv)
        -- end

        -- match = vim.fn.glob(tostring(workspace_path / "pyproject.toml"))
        -- if match ~= "" then
        -- 	local rye_show_output = vim.fn.trim(vim.fn.system("rye show"))
        -- 	local _, venv_start_index = string.find(rye_show_output, "venv: ")
        -- 	local venv_end_index = string.find(rye_show_output, "\n", venv_start_index + 1)
        -- 	local venv = vim.fn.trim(string.sub(rye_show_output, venv_start_index, venv_end_index))
        -- 	update_venv_path(venv)
        -- 	return format_python_path(venv)
        -- end

        -- Find and use virtualenv from pipenv in workspace directory.
        -- match = vim.fn.glob(tostring(workspace_path / "Pipfile"))
        -- if match ~= "" then
        -- 	local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv"))
        -- 	return format_python_path(venv)
        -- end

        -- Find .venv folder
        local dot_venv_path = tostring(workspace_path / ".venv")
        if vim.fn.isdirectory(dot_venv_path) == 1 then
            update_venv_path(dot_venv_path)
            return format_python_path(dot_venv_path)
        end

        -- Fallback to system Python.
        return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
    end

    local python_config = vim.tbl_deep_extend("force", config, {
        on_init = function(client)
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

    lsp_config["basedpyright"].setup(python_config)
    lsp_config["ruff"].setup(python_config)
end

return M
