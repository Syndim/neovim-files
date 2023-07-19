local global = {}
local os_name = vim.loop.os_uname()
local system = os_name.sysname
local release = os_name.release

function global:load_variables()
    self.is_mac      = string.find(system, 'Darwin') ~= nil
    self.is_linux    = string.find(system, 'Linux') ~= nil
    self.is_windows  = string.find(system, 'Windows') ~= nil
    self.is_wsl      = string.find(release, 'WSL') ~= nil
    self.is_embedded = vim.g.shadowvim or vim.g.vscode
end

function global:which(cmd)
    local redirect = ' > /dev/null 2>&1'
    ---@diagnostic disable-next-line: redefined-local
    local which = 'which'
    if global.is_windows then
        redirect = ' > nul 2>&1'
        which = 'where.exe'
    end

    return os.execute(which .. ' ' .. cmd .. redirect)
end

global:load_variables()

return global
