local M = {}

function M.setup(config)
    -- lsp_config['pylsp'].setup(config)

    -- Below config are for ty/ruff (basedpyright is disabled, see below).
    local global = require("global")
    local Path = require("plenary.path")

    local function venv_bin_dir(venv)
        local venv_path = Path:new(venv)
        return tostring(global.is_windows and (venv_path / "Scripts") or (venv_path / "bin"))
    end

    local function get_git_root(workspace)
        local result = vim.fn.system({ "git", "-C", workspace, "rev-parse", "--show-toplevel" })
        if vim.v.shell_error ~= 0 then
            return nil
        end

        return vim.fn.trim(result)
    end

    -- Find the project's virtualenv. Checked in order:
    -- 1. An already-active VIRTUAL_ENV (e.g. nvim launched from an
    --    activated shell).
    -- 2. A `.venv` directory in the LSP workspace root.
    -- 3. A `.venv` directory at the git root. The workspace root for a
    --    package inside a monorepo (e.g. Monty) may not be the git root,
    --    so the git root is checked as a fallback.
    local function find_venv(workspace)
        if vim.env.VIRTUAL_ENV and vim.fn.isdirectory(vim.env.VIRTUAL_ENV) == 1 then
            return vim.env.VIRTUAL_ENV
        end

        local search_roots = { workspace }
        local git_root = get_git_root(workspace)
        if git_root and git_root ~= workspace then
            table.insert(search_roots, git_root)
        end

        for _, root in ipairs(search_roots) do
            local dot_venv = tostring(Path:new(root) / ".venv")
            if vim.fn.isdirectory(dot_venv) == 1 then
                return dot_venv
            end
        end

        return nil
    end

    -- Wrap `base_cmd` so the venv is resolved and injected into the
    -- spawned process's environment (VIRTUAL_ENV/PATH) *before* the
    -- server starts, which is what ty and ruff use to discover the
    -- project's virtualenv.
    --
    -- This must happen at spawn time: Neovim spawns the LSP process
    -- before running `before_init`/`on_init` (see vim.lsp.client.lua,
    -- `Client:new()` starts `config.cmd` before `Client:initialize()`
    -- ever runs a callback), so mutating `vim.env` from `on_init` is one
    -- launch too late -- the server already inherited the old
    -- environment. That's why restarting the LSP after opening a file
    -- used to be required: only the *next* spawn would see the env
    -- update from the previous attempt's `on_init`.
    local function make_cmd(base_cmd)
        return function(dispatchers, client_config)
            local workspace = client_config.root_dir or vim.fn.getcwd()
            local venv = find_venv(workspace)
            local env

            if venv then
                local sep = global.is_windows and ";" or ":"
                env = {
                    VIRTUAL_ENV = venv,
                    PATH = venv_bin_dir(venv) .. sep .. (vim.env.PATH or ""),
                }
            end

            return vim.lsp.rpc.start(base_cmd, dispatchers, {
                cwd = client_config.cmd_cwd,
                env = env,
                detached = client_config.detached,
            })
        end
    end

    local python_config = vim.tbl_deep_extend("force", config, {
        on_attach = function(client, bufnr)
            config.on_attach(client, bufnr)
            if client.name == "ruff" then
                -- Disable hover in favor of Pyright
                client.server_capabilities.hoverProvider = false
            end
        end,
    })

    local function enable(name)
        local base_cmd = vim.lsp.config[name].cmd
        vim.lsp.config(name, vim.tbl_deep_extend("force", python_config, { cmd = make_cmd(base_cmd) }))
        vim.lsp.enable(name)
    end

    -- vim.lsp.enable("basedpyright")
    enable("ruff")
    enable("ty")
end

return M
