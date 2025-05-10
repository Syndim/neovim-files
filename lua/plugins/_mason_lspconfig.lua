local M = {}

function M.config()
	local global = require("global")
	require("utils")

	local mason = require("mason")
	local mason_lsp_config = require("mason-lspconfig")
	local lsp = require("plugins._lsp")
	local lsp_config = require("lspconfig")
	local common_servers = {
		"neocmake",
		"cssls",
		"dockerls",
		"html",
		"jsonls",
		"eslint",
		"taplo", -- toml
		"bashls",
		"yamlls",
		"kotlin_language_server",
		-- "typos_lsp",
		"harper_ls",
	}

	local optional_servers = {
		powershell_es = "pwsh",
		-- solargraph    = 'ruby',
	}

	mason.setup({
		log_level = vim.log.levels.DEBUG,
		registries = {
			"github:mason-org/mason-registry",
			"github:Crashdummyy/mason-registry",
		},
		github = {
			download_url_template = global.github.url .. "/%s/releases/download/%s/%s",
		},
	})

	local servers = vim.tbl_extend("force", {}, common_servers)
	vim.list_extend(servers, {
		"rust_analyzer",
		"ts_ls",
		"lua_ls",
		"clangd",
		"basedpyright",
		"ruff",
	})

	for name, condition in pairs(optional_servers) do
		if global:which(condition) == 0 then
			table.insert(servers, name)
		end
	end

	mason_lsp_config.setup({
		ensure_installed = servers,
		automatic_enable = false,
	})

	local mason_registry = require("mason-registry")

	-- Use proxy for schema file
	mason_registry:on(
		"package:handle",
		vim.schedule_wrap(function(package, handle)
			if package.spec.schemas ~= nil then
				if package.spec.schemas.lsp:starts_with("vscode:https://raw.githubusercontent.com") then
					package.spec.schemas.lsp =
						package.spec.schemas.lsp:replace("vscode:https://github.com", "vscode:" .. global.github.url)
				end
			end
		end)
	)

	-- Specify the default options which we'll use to setup all servers
	local config = lsp.create_config()

	-- Common LSP
	for _, name in ipairs(common_servers) do
		lsp_config[name].setup(config)
	end

	-- Custom settings
	require("plugins._lsp_lua").setup(lsp_config, config)
	require("plugins._lsp_clang").setup(lsp_config, config)
	require("plugins._lsp_python").setup(lsp_config, config)
	-- require("plugins._lsp_typescript").setup(lsp_config, config)

	if global:which("flutter") == 0 or global:which("fvm") == 0 then
		require("plugins._lsp_flutter").setup(lsp, config)
	end

	if global:which("swift") == 0 then
		require("plugins._lsp_sourcekit").setup(lsp_config, config)
	end

	-- Optional LSP
	for name, condition in pairs(optional_servers) do
		if global:which(condition) == 0 then
			lsp_config[name].setup(config)
		end
	end
end

return M
