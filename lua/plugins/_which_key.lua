local M = {}

function M.config()
	local wk = require("which-key")
	local show = wk.show
	wk.show = function(keys, opts)
		if vim.bo.filetype == "TelescopePrompt" then
			return
		end
		show(keys, opts)
	end
	vim.api.nvim_exec(
		[[
    augroup telescope
        autocmd!
        autocmd FileType TelescopePrompt inoremap <buffer> <silent> <C-r> <C-r>
    augroup END]],
		false
	)
	wk.setup({})
end

return M
