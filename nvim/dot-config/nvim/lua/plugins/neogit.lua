---@type LazyPluginSpec
return {
	'NeogitOrg/neogit',
	lazy = true,
	dependencies = {
		'nvim-lua/plenary.nvim',
		'esmuellert/codediff.nvim',
		'folke/snacks.nvim',
	},
	cmd = 'Neogit',
	keys = {
		{ '<leader>ng', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
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
