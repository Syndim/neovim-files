local M = {}

function M.setup(lsp_config, config)
    -- lsp_config['pylsp'].setup(config)

    -- Below config are for pyright
    local util = require('lspconfig/util')
    local global = require('global')
    local path = util.path
    -- print(vim.env.VIRTUAL_ENV)

    local function update_venv_path(venv)
        vim.env.VIRTUAL_ENV = venv
        if global.is_windows then
            vim.env.PATH = path.join(venv, 'bin') .. ';' .. vim.env.PATH
        else
            vim.env.PATH = path.join(venv, 'bin') .. ':' .. vim.env.PATH
        end
    end

    local function get_python_path(workspace)
        -- Use activated virtualenv.
        if vim.env.VIRTUAL_ENV then
            update_venv_path(vim.env.VIRTUAL_ENV)
            return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
        end

        -- Find and use venv from poetry
        local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
        if match ~= '' then
            local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
            update_venv_path(venv)
            return path.join(venv, 'bin', 'python')
        end

        match = vim.fn.glob(path.join(workspace, 'pyproject.toml'))
        if match ~= '' then
            local rye_show_output = vim.fn.trim(vim.fn.system('rye show'))
            local _, venv_start_index = string.find(rye_show_output, 'venv: ')
            local venv_end_index = string.find(rye_show_output, '\n', venv_start_index + 1)
            local venv = vim.fn.trim(string.sub(rye_show_output, venv_start_index, venv_end_index))
            update_venv_path(venv)
            return path.join(venv, 'bin', 'python')
        end

        -- Find and use virtualenv from pipenv in workspace directory.
        match = vim.fn.glob(path.join(workspace, 'Pipfile'))
        if match ~= '' then
            local venv = vim.fn.trim(vim.fn.system('PIPENV_PIPFILE=' .. match .. ' pipenv --venv'))
            return path.join(venv, 'bin', 'python')
        end

        -- Find .venv folder
        local dot_venv_path = path.join(workspace, '.venv')
        if vim.fn.isdirectory(dot_env_path) == 1 then
            update_venv_path(dot_venv_path)
            return path.join(dot_venv_path, 'bin', 'python')
        end

        -- Fallback to system Python.
        return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
    end

    local python_config = vim.tbl_deep_extend('force', config, {
        on_init = function(client)
            client.config.settings.python = client.config.settings.python or {}
            client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
        end
    })

    lsp_config['pyright'].setup(python_config)
    lsp_config['ruff'].setup(python_config)
end

return M
