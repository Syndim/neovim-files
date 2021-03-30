local M = {}

function M.config()
    local cmd = vim.cmd
    cmd('au VimEnter * RainbowParenthesesToggle')
    cmd('au Syntax * RainbowParenthesesLoadRound')
    cmd('au Syntax * RainbowParenthesesLoadSquare')
    cmd('au Syntax * RainbowParenthesesLoadBraces')
end

return M
