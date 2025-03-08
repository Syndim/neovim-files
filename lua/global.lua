local global = {}
local os_name = vim.loop.os_uname()
local system = os_name.sysname
local release = os_name.release

local function redirect_str()
	if global.is_windows then
		return " > nul 2>&1"
	else
		return " > /dev/null 2>&1"
	end
end

function global:load_variables()
	self.is_mac = string.find(system, "Darwin") ~= nil
	self.is_linux = string.find(system, "Linux") ~= nil
	self.is_windows = string.find(system, "Windows") ~= nil
	self.is_wsl = string.find(release, "WSL") ~= nil
	self.is_embedded = vim.g.shadowvim or vim.g.vscode
	self.is_in_xcode = vim.g.shadowvim
	self.github = {
		url = os.getenv("GITHUB_URL") or "https://github.com",
		raw_url = os.getenv("RAW_GITHUB_URL") or "https://raw.githubusercontent.com",
	}
	self.github.has_proxy = self.github.url ~= "http://github.com"
	self.redirect = redirect_str()
end

function global:which(cmd)
	local redirect = self.redirect
	local which = "which"
	if self.is_windows then
		which = "where.exe"
	end

	return os.execute(which .. " " .. cmd .. redirect)
end

global:load_variables()

return global
