local global = require('global')

local o = vim.o
local wo = vim.wo
local g = vim.g
local cmd = vim.cmd

-- Syntax on
o.syntax = 'on'

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
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'

-- Enable hidden buffers
o.hidden = true

-- Mouse model
o.mousemodel = 'popup'

-- Windows behavior
cmd('source $VIMRUNTIME/mswin.vim')
cmd('behave mswin')

-- GUI colors
o.termguicolors = true

-- Enable hidden buffers
-- o.hidden = true

-- Fonts
if global.is_windows then
    o.guifont = 'FiraCode NF:h14'
else
    o.guifont = 'FiraCode Nerd Font Mono:h18'
end

g.mapleader = ','

if global.is_windows then
    o.shell = 'cmd.exe'
elseif global.is_linux or global.is_mac then
    o.shell = 'bash'
end

if global.is_windows then
    o.ffs = 'dos,unix,mac'
else
    o.ffs = 'unix,dos,mac'
end

-- o.signcolumn = 'number'
-- wo.signcolumn = 'number'
