local M = {}

local function setup_telescope()
	local Hydra = require("hydra")
	local cmd = require("hydra.keymap-util").cmd
	local hint = [[
                 _f_: files       _m_: marks
                 _o_: old files   _g_: live grep
                 _p_: projects    _/_: search in file
                 _r_: resume      _u_: undotree
                 _h_: vim help    _c_: execute command
                 _k_: keymaps     _;_: commands history
                 _O_: options     _?_: search history
                 _<Enter>_: Telescope           _<Esc>_
]]

	Hydra({
		name = "Telescope",
		hint = hint,
		config = {

			color = "teal",

			invoke_on_body = true,

			hint = {
				position = "middle",
				border = "rounded",
			},
		},
		mode = "n",

		body = "<Leader>f",
		heads = {
			{ "f", cmd("Telescope find_files") },
			{ "g", cmd("Telescope live_grep") },
			{ "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },

			{ "h", cmd("Telescope help_tags"), { desc = "vim help" } },
			{ "m", cmd("MarksListBuf"), { desc = "marks" } },
			{ "k", cmd("Telescope keymaps") },
			{ "O", cmd("Telescope vim_options") },
			{ "r", cmd("Telescope resume") },
			{ "p", cmd("Telescope projects"), { desc = "projects" } },
			{ "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
			{ "?", cmd("Telescope search_history"), { desc = "search history" } },
			{ ";", cmd("Telescope command_history"), { desc = "command-line history" } },
			{ "c", cmd("Telescope commands"), { desc = "execute command" } },
			{ "u", cmd("silent! %foldopen! | UndotreeToggle"), { desc = "undotree" } },

			{ "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
			{ "<Esc>", nil, { exit = true, nowait = true } },
		},
	})
end

local function setup_window_management()
	local Hydra = require("hydra")
	local splits = require("smart-splits")

	local cmd = require("hydra.keymap-util").cmd
	local pcmd = require("hydra.keymap-util").pcmd

	local window_hint = [[
 ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
 ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally
 _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_, _c_: close
 focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
 _b_: choose buffer
]]

	Hydra({
		name = "Windows",
		hint = window_hint,
		config = {
			invoke_on_body = true,
			hint = {
				border = "rounded",

				offset = -1,
			},
		},
		mode = "n",
		body = "<C-w>",
		heads = {
			{ "h", "<C-w>h" },
			{ "j", "<C-w>j" },
			{ "k", pcmd("wincmd k", "E11", "close") },
			{ "l", "<C-w>l" },

			{ "H", cmd("WinShift left") },
			{ "J", cmd("WinShift down") },
			{ "K", cmd("WinShift up") },
			{ "L", cmd("WinShift right") },

			{
				"<C-h>",
				function()
					splits.resize_left(2)
				end,
			},
			{
				"<C-j>",
				function()
					splits.resize_down(2)
				end,
			},
			{
				"<C-k>",
				function()
					splits.resize_up(2)
				end,
			},
			{
				"<C-l>",
				function()
					splits.resize_right(2)
				end,
			},
			{ "=", "<C-w>=", { desc = "equalize" } },

			{ "s", pcmd("split", "E36") },

			{ "<C-s>", pcmd("split", "E36"), { desc = false } },
			{ "v", pcmd("vsplit", "E36") },

			{ "<C-v>", pcmd("vsplit", "E36"), { desc = false } },

			{ "w", "<C-w>w", { exit = true, desc = false } },
			{ "<C-w>", "<C-w>w", { exit = true, desc = false } },

			{ "z", cmd("WindowsMaximaze"), { exit = true, desc = "maximize" } },
			{ "<C-z>", cmd("WindowsMaximaze"), { exit = true, desc = false } },

			{ "o", "<C-w>o", { exit = true, desc = "remain only" } },
			{ "<C-o>", "<C-w>o", { exit = true, desc = false } },

			{ "b", choose_buffer, { exit = true, desc = "choose buffer" } },

			{ "c", pcmd("close", "E444") },
			{ "q", pcmd("close", "E444"), { desc = "close window" } },

			{ "<C-c>", pcmd("close", "E444"), { desc = false } },

			{ "<C-q>", pcmd("close", "E444"), { desc = false } },

			{ "<Esc>", nil, { exit = true, desc = false } },
		},
	})
end

function M.config()
	setup_telescope()
	setup_window_management()
end

return M
