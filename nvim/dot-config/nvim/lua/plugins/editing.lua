return {
	---@type LazyPluginSpec
	{

		'nvimdev/hlsearch.nvim',
		event = 'BufRead',
		config = true,
	},
	---@type LazyPluginSpec
	{
		'kylechui/nvim-surround',
		version = '*',
		event = 'VeryLazy',
		opts = {
			move_cursor = false,
		},
		config = true,
	},
}
