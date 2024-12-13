local global = require("global")

local o = vim.o
local wo = vim.wo
local g = vim.g
local cmd = vim.cmd

-- Syntax on
o.syntax = "on"

-- Search
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.incsearch = true

-- Tabs
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 0
o.expandtab = true

-- Line number
o.number = true
wo.number = true
o.ruler = true
o.relativenumber = true
wo.relativenumber = true

-- Encoding
o.encoding = "utf-8"
o.fileencoding = "utf-8"

-- Enable hidden buffers
o.hidden = true

-- Mouse model
o.mousemodel = "popup"

-- Windows behavior
cmd("source $VIMRUNTIME/mswin.vim")
cmd("set selection=exclusive")
cmd("set selectmode=mouse,key")
cmd("set mousemodel=popup")
cmd("set keymodel=startsel,stopsel")

-- GUI colors
o.termguicolors = true

-- Enable hidden buffers
-- o.hidden = true

-- Fonts
-- For neovide and goneovim the font setting is done through config.toml
if not g.neovide and not g.gonvim_running then
	if global.is_windows then
		o.guifont = "FiraCode Nerd Font Mono:h14"
	else
		o.guifont = "FiraCode Nerd Font Mono:h18"
	end
end

g.mapleader = ","

if global.is_windows then
	local home = os.getenv("HOME")
	if home then
		o.shell = "powershell.exe -NoExit -File " .. home .. "/.config/powershell/setup/setup.ps1"
	else
		o.shell = "powershell.exe"
	end
elseif global.is_linux or global.is_mac then
	o.shell = "fish"
end

if global.is_windows then
	o.ffs = "dos,unix,mac"
else
	o.ffs = "unix,dos,mac"
end

g.grepprg = "grepprg=rg --vimgrep --no-heading"

-- Load project config file
o.exrc = true
-- o.signcolumn = 'number'
-- wo.signcolumn = 'number'

-- disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- global status bar
-- o.cmdheight = 0
o.laststatus = 3
