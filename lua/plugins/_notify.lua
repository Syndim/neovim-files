local M = {}

function M.config()
	local notify = require("notify")
	notify.setup({
		timeout = 3000,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
	})
	vim.notify = function(msg, level, opts)
		if string.len(msg) > 0 then
			return notify.notify(msg, level, opts)
		end
	end

	local opts = {
		remap = false,
	}

	opts.desc = "Close notification"
	vim.keymap.set("n", "<leader>dn", notify.dismiss, opts)
end

return M
