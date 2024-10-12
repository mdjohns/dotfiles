return {
	'stevearc/oil.nvim',
	dependencies = {
		{ 'echasnovski/mini.icons', opts = {} },
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
