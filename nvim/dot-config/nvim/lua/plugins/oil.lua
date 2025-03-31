return {
	'stevearc/oil.nvim',
	dependencies = {
		{ 'echasnovski/mini.icons', opts = {} },
	},
	config = function()
		require('oil').setup {
			keymaps = {
				['<leader>y'] = {
					'actions.yank_entry',
				},
			},
		}
	end,
	keys = {
		{
			'-',
			'<cmd>Oil<cr>',
			desc = 'Open parent directory',
		},
	},
}
