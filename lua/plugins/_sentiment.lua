local M = {}

function M.config()
	local sentiment = require("sentiment")
	sentiment.setup({})
	sentiment.enable()
end

return M
