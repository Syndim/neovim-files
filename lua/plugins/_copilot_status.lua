local M = {}

local copilot_init_finished = false

function M.status()
    if copilot_init_finished then
        return require('copilot_status').status_string()
    end

    return ''
end

function M.config()
    require('copilot_status').setup({
        icons = {
            idle = '',
            error = '',
            offline = '',
            warning = '',
            loading = '',
        },
    })

    copilot_init_finished = true
end

return M
