return {
	'stevearc/oil.nvim',
	dependencies = {
		{ 'nvim-tree/nvim-web-devicons', version = false, config = true },
	},
	config = true,
	keys = {
		{
			'-',
			'<cmd>Oil<cr>',
			desc = 'Open parent directory',
		},
	},
}
