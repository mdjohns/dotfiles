local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.expandtab = true

opt.ignorecase = true
opt.smartcase = true

opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }
opt.shortmess:append 'c'
