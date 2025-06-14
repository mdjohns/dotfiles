--- @type LazyPluginSpec
return {
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
		'ibhagwan/fzf-lua',
	},
	opts = {
		kind = 'floating',
	},
	config = true,
}
