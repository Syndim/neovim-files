local M = {}

function M.setup(lsp_config, config)
    -- lsp_config['pylsp'].setup(config)

    -- Below config are for pyright
    local util = require('lspconfig/util')
    local global = require('global')
    local path = util.path

    local function get_python_path(workspace)
        -- Use activated virtualenv.
        if vim.env.VIRTUAL_ENV then
            return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
        end

        -- Find and use venv from poetry
        local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
        if match ~= '' then
            local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
            vim.env.VIRTUAL_ENV = venv
            if global.is_windows then
                vim.env.PATH = path.join(venv, 'bin') .. ';' .. vim.env.PATH
            else
                vim.env.PATH = path.join(venv, 'bin') .. ':' .. vim.env.PATH
            end
            return path.join(venv, 'bin', 'python')
        end

        -- Find and use virtualenv from pipenv in workspace directory.
        match = vim.fn.glob(path.join(workspace, 'Pipfile'))
        if match ~= '' then
            local venv = vim.fn.trim(vim.fn.system('PIPENV_PIPFILE=' .. match .. ' pipenv --venv'))
            return path.join(venv, 'bin', 'python')
        end

        -- Fallback to system Python.
        return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
    end

    local python_config = vim.tbl_deep_extend('force', config, {
        on_init = function(client)
            client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
        end
    })

    lsp_config['pyright'].setup(python_config)
end

return M
