local M = {}

function M.install()
    local execute = function(name, cmd)
        local os = require('os')
        print('Start installing ' .. name)
        os.execute(cmd)
        print('Finished installing ' .. name)
    end

    execute('pyright', 'npm install -g pyright')
    execute('tsserver', 'npm install -g typescript typescript-language-server')
    execute('solargraph', 'gem install --user-install solargraph')
    execute('html', 'npm i -g vscode-langservers-extracted')
end

return M
