return {
	'stevearc/oil.nvim',
	dependencies = {
		{ 'echasnovski/mini.icons' },
	},
	config = function()
		require('oil').setup {
			git = {
				mv = function(_path)
					-- automatically `git mv` files
					return true
				end,
			},
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
