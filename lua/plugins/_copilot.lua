local M = {}

local copilot_initiazlied = false

local function is_enabled()
	if vim.g.loaded_copilot == 1 and vim.fn["copilot#Enabled"]() == 1 then
		return true
	else
		return false
	end
end

local function is_running()
	local agent = vim.g.loaded_copilot == 1 and vim.fn["copilot#RunningClient"]() or nil
	if not agent then
		return false
	end
	-- most of the time, requests is just empty dict.
	local requests = agent.requests or {}

	-- requests is dict with number as index, get status from those requests.
	for _, req in pairs(requests) do
		local req_status = req.status
		if req_status == "running" then
			return true
		end
	end
	return false
end

function M.status()
	if copilot_initiazlied then
		if is_running() then
			return ""
		elseif is_enabled() then
			return ""
		else
			return ""
		end
	end

	return ""
end

function M.setup()
	vim.g.copilot_no_tab_map = true
end

function M.config()
	local opts = { expr = true, replace_keycodes = false }
	opts.desc = "Accept copilot suggestion"
	vim.keymap.set("i", "<C-f>", function()
		return vim.fn["copilot#Accept"]("\\<CR>")
	end, opts)
	copilot_initiazlied = true
end

return M
