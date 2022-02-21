local function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then io.close(f) return true else return false end
end

local function load()
    local local_rc_name = ".nvimrc.lua"
    if (file_exists(local_rc_name)) then
        dofile(local_rc_name)
    end
end

load()
