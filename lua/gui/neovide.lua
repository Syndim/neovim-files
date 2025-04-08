local g = vim.g
if not g.neovide then
	return
end

g.neovide_remember_window_size = true

local global = require("global")

-- api.nvim_create_autocmd({ 'UIEnter' }, {
--     callback = function()
--         if global.is_wsl and vim.g.neovide then
--             vim.o.guifont = 'FiraCode Nerd Font Mono:h14'
--         end
--     end
-- })

if global.is_mac then
	vim.g.neovide_input_macos_option_key_is_meta = "both"
elseif global.is_wsl then
	-- Neovide under wsl will fetch new set of environments and VIRTUAL_ENV
	-- environment variable somehow get lost
	-- So we reset it here
	local util = require("lspconfig/util")
	local path = util.path
	local fn = vim.fn
	local cwd = fn.getcwd()
	local match = fn.glob(path.join(cwd, "poetry.lock"))
	if match ~= "" then
		local venv = fn.trim(vim.fn.system("poetry env info -p"))
		vim.env.VIRTUAL_ENV = venv
		vim.env.PATH = path.join(venv, "bin") .. ":" .. vim.env.PATH
	end

	local node_path = fn.trim(vim.fn.system("volta which node"))
	vim.env.PATH = vim.fs.dirname(node_path) .. ":" .. vim.env.PATH
	local dotnet_root = fn.trim(fn.system("brew --prefix dotnet"))
	vim.env.DOTNET_ROOT = path.join(dotnet_root, "libexec")
end
