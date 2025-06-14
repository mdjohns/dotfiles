---@type LazyPluginSpec
return {
	'aaronik/treewalker.nvim',
	event = 'BufRead',
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	config = function()
		require('treewalker').setup {
			highlight = true,
		}

		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }
		map('n', '<M-h>', ':Treewalker Left<CR>', opts)
		map('n', '<M-j>', ':Treewalker Down<CR>', opts)
		map('n', '<M-k>', ':Treewalker Up<CR>', opts)
		map('n', '<M-l>', ':Treewalker Right<CR>', opts)
	end,
}
