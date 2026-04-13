local set = vim.keymap.set

vim.g.mapleader = ' '

set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })

set('n', '<M-,>', '<c-w>5<', { desc = 'Decrease width of current split' })
set('n', '<M-.>', '<c-w>5>', { desc = 'Increase width of current split' })
set('n', '<M-t>', '<c-w>+', { desc = 'Make current split [t]aller' })
set('n', '<M-s>', '<c-w>-', { desc = 'Make current split [s]horter' })
