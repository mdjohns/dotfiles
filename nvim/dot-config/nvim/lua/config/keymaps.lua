local set = vim.keymap.set

vim.g.mapleader = ' '

set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
