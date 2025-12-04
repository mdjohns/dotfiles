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
		auto_show_console = false,
		graph_style = 'kitty',
		kind = 'floating',
		commit_editor = {
			kind = 'floating',
		},
		rebase_editor = {
			kind = 'floating',
		},
	},
	config = true,
}
