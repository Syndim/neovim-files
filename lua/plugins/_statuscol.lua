local M = {}

function M.config()
    local builtin = require('statuscol.builtin')
    require('statuscol').setup({
        relculright = true,
        segments = {
            {
                sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true },
                click = "v:lua.ScSa"
            },
            {
                text = { builtin.lnumfunc, " " },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScLa",
            }
        }
    })
end

return M
