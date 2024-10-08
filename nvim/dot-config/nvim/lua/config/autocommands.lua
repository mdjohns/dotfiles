local yank_group = vim.api.nvim_create_augroup('HighlightYank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank { higroup = 'Visual', timeout = 200 }
	end,
	group = yank_group,
})
