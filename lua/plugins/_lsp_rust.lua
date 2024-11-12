local M = {}

function M.config()
	require("mason-lspconfig").setup_handlers({
		["rust_analyzer"] = function() end,
	})

	local lsp = require("plugins._lsp")
	local config = lsp.create_config()

	local on_attach = function(client, bufnr)
		config.on_attach(client, bufnr)
		local opts = { remap = false, buffer = bufnr }
		opts.desc = "Expand macro"
		vim.keymap.set("n", "<leader>em", function()
			vim.cmd.RustLsp("expandMacro")
		end, opts)
		-- opts.desc = 'Rust code action'
		-- vim.keymap.set('n', '<leader>ca', function() vim.cmd.RustLsp('codeAction') end, opts)
	end

	local features = require("features")

	local default_settings = {
		-- to enable rust-analyzer settings visit:
		-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
		["rust-analyzer"] = {
			-- enable clippy on save
			-- check = {
			--     command = 'check'
			-- },
			-- procMacro = {
			--     enable = true
			-- }
		},
	}

	if features.lsp_config["rust"] ~= nil then
		default_settings = vim.tbl_deep_extend("force", default_settings, features.lsp_config["rust"])
	end

	local rust_config = vim.tbl_deep_extend("force", config, {
		standalone = true,
		default_settings = default_settings,
	})

	rust_config.on_attach = on_attach
	rust_config.cmd = function()
		local data_path = vim.fn.stdpath("data")
		local dir = data_path .. "/mason/bin/"
		local ra_binary = vim.fn.glob(dir .. "rust-analyzer*")
		return { ra_binary } -- You can add args to the list, such as '--log-file'
	end

	local global = require("global")
	-- local utils = require('utils')
	--
	-- if os.execute('rustup which rust-analyzer' .. global.redirect) ~= 0 then
	--     vim.notify('Installing rust-analyzer')
	--     utils.start_cmd('rustup', { 'component', 'add', 'rust-analyzer' }, function(code)
	--         if code == 0 then
	--             vim.notify('rust-analyzer installed')
	--         else
	--             vim.notify("rust-analyzer failed to install")
	--         end
	--     end)
	-- end

	vim.g.rustaceanvim = {
		server = rust_config,
		tools = {
			code_actions = {
				ui_select_fallback = not global.is_windows,
			},
			enable_clippy = false,
		},
	}
end

return M
