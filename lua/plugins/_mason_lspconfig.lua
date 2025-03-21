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
		"typos_lsp",
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
	mason_lsp_config.setup({
		automatic_installation = true,
	})

	local mason_registry = require("mason-registry")
	-- Patch assets
	-- if global.is_windows then
	--     local taplo_assets = mason_registry.get_package('taplo').spec.source.asset
	--     table.insert(taplo_assets, {
	--         target = 'win_x64',
	--         file = 'taplo-full-windows-x86_64.zip',
	--         bin = 'taplo.exe'
	--     })
	-- end

	-- local efm_spec = mason_registry.get_package('efm').spec
	-- efm_spec.source = {
	--     asset = {
	--         {
	--             target = 'win_x64',
	--             file = 'efm-langserver_{{version}}_windows_amd64.zip',
	--             bin = 'efm-langserver_{{version}}_windows_amd64/efm-langserver.exe'
	--         },
	--         {
	--             target = 'linux_x64',
	--             file = 'efm-langserver_{{version}}_linux_amd64.tar.gz',
	--             bin = 'efm-langserver_{{version}}_linux_amd64/efm-langserver'
	--         },
	--         {
	--             target = 'darwin_arm64',
	--             file = 'efm-langserver_{{version}}_darwin_arm64.zip',
	--             bin = 'efm-langserver_{{version}}_darwin_arm64/efm-langserver'
	--         },
	--         {
	--             target = 'darwin_x64',
	--             file = 'efm-langserver_{{version}}_darwin_amd64.zip',
	--             bin = 'efm-langserver_{{version}}_darwin_amd64/efm-langserver'
	--         }
	--     },
	--     id = efm_spec.source.id:replace('pkg:golang/github.com', 'pkg:github')
	-- }
	-- efm_spec.bin['efm-langserver'] = '{{source.asset.bin}}'

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
	-- require('plugins._lsp_typescript').setup(lsp_config, config)
	-- require('plugins._lsp_slint').setup(config)

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
