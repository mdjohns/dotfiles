local o = vim.o
local opt = vim.opt

o.confirm = true

o.number = true
o.relativenumber = true

o.tabstop = 2
o.shiftwidth = 2
o.shiftround = true
o.expandtab = true

o.ignorecase = true
o.smartcase = true

o.showmode = false

opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }
opt.shortmess:append 'c'

opt.cmdheight = 0
opt.laststatus = 3

o.swapfile = false

o.winborder = 'rounded'
