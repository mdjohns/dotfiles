---@type LazyPluginSpec[]
return {
	{
		'lewis6991/gitsigns.nvim',
		event = 'BufRead',
		opts = {
			current_line_blame = true,
		},
	},
	{
		'NeogitOrg/neogit',
		keys = {
			{
				'<leader>ng',
				'<cmd>Neogit<cr>',
				desc = 'Open Neogit',
			},
		},
		dependencies = {
			'nvim-lua/plenary.nvim',
			'sindrets/diffview.nvim',
			'nvim-telescope/telescope.nvim',
		},
		config = true,
	},
}
