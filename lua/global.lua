local global = {}
local os_name = vim.loop.os_uname().sysname

function global:load_variables()
  self.is_mac     = string.find(os_name, 'Darwin') ~= nil
  self.is_linux   = string.find(os_name, 'Linux') ~= nil
  self.is_windows = string.find(os_name, 'Windows') ~= nil
end

global:load_variables()

return global
