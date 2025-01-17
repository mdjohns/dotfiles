local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanks
autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank { higroup = 'Visual', timeout = 200 }
	end,
	group = augroup('HighlightYank', { clear = true }),
})

-- Restart `prettierd` when a prettier config file has been changed
autocmd({ 'BufWritePost' }, {
	callback = function()
		vim.fn.system 'prettierd restart'
	end,
	group = augroup('RestartPrettierd', { clear = true }),
	pattern = '*prettier*',
})
