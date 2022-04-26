local global = {}
local os_name = vim.loop.os_uname()
local system = os_name.sysname
local release = os_name.release

function global:load_variables()
    self.is_mac     = string.find(system, 'Darwin') ~= nil
    self.is_linux   = string.find(system, 'Linux') ~= nil
    self.is_windows = string.find(system, 'Windows') ~= nil
    self.is_wsl     = string.find(release, 'WSL') ~= nil
end

global:load_variables()

return global
