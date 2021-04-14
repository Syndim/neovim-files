local g = vim.g
local cmd = vim.cmd
local fn = vim.fn

cmd('nnoremap <C-p> :FZF<CR>')

if fn.executable('rg') then
    cmd("let $FZF_DEFAULT_COMMAND='rg --files'")
    cmd('set grepprg=rg\\ --vimgrep')
end

g.fzf_buffers_jump = 1
g.fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
g.fzf_tags_command = 'ctags -R'
g.fzf_commands_expect = 'alt-enter,ctrl-x'
