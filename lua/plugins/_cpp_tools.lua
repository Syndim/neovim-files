local M = {}

function M.config()
	require("nt-cpp-tools").setup({
		preview = {
			quit = "q",
			accept = "<C-f>",
		},
	})

	vim.keymap.set(
		{ "n", "v" },
		"<Leader>cdc",
		vim.cmd.TSCppDefineClassFunc,
		{ remap = false, desc = "Generate class definition" }
	)
	vim.keymap.set(
		{ "n", "v" },
		"<Leader>cmc",
		vim.cmd.TSCppMakeConcreteClass,
		{ remap = false, desc = "Generate concrete class from interface" }
	)
end

return M
