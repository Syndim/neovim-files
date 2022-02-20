local M = {}

function execute(table, index)
    local Terminal  = require('toggleterm.terminal').Terminal
    local next_index = next(table, index)
    local cmd = table[next_index]
    if cmd then
        Terminal:new({ cmd = 'echo Installing LSP ' .. next_index .. ' & ' .. cmd, close_on_exit = true, on_close = function() execute(table, next_index) end }):toggle()
    end
end

function M.install()
    local cmd_list = {
        pyright = 'npm install -g pyright',
        tsserver = 'npm install -g typescript typescript-language-server',
        solargraph = 'gem install --user-install solargraph',
        html = 'npm i -g vscode-langservers-extracted'
    }

    execute(cmd_list, nil)
end

return M
