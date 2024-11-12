function string:contains(sub)
	return self:find(sub, 1, true) ~= nil
end

function string:starts_with(start)
	return self:sub(1, #start) == start
end

function string:ends_with(ending)
	return ending == "" or self:sub(-#ending) == ending
end

function string:replace(old, new)
	local s = self
	local search_start_idx = 1

	while true do
		local start_idx, end_idx = s:find(old, search_start_idx, true)
		if not start_idx then
			break
		end

		local postfix = s:sub(end_idx + 1)
		s = s:sub(1, (start_idx - 1)) .. new .. postfix

		search_start_idx = -1 * postfix:len()
	end

	return s
end

function string:insert(pos, text)
	return self:sub(1, pos - 1) .. text .. self:sub(pos)
end

function start_cmd(cmd, args, on_exit)
	local function on_stdout(err, data)
		if err then
			print("ERROR: ", err)
		end
		if data then
			print("OUTPUT: ", data)
		end
	end

	-- 启动一个后台任务
	local handle = vim.loop.spawn(cmd, {
		args = args,
		stdio = { nil, vim.loop.new_pipe(false), vim.loop.new_pipe(false) },
	}, vim.schedule_wrap(on_exit))

	vim.loop.read_start(handle.stdout, vim.schedule_wrap(on_stdout))
	vim.loop.read_start(handle.stderr, vim.schedule_wrap(on_stdout))
end

return {
	start_cmd = start_cmd,
}
