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

opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }
opt.shortmess:append 'c'
