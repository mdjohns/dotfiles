---@type LazyPluginSpec[]
return {
	{

		'nvimdev/hlsearch.nvim',
		event = 'BufRead',
		config = true,
	},
	{
		'kylechui/nvim-surround',
		version = '*',
		event = 'VeryLazy',
		opts = {
			move_cursor = false,
		},
		config = true,
	},
	{
		'echasnovski/mini.pairs',
		version = false,
		event = 'VeryLazy',
		config = true,
	},
	{
		'Rrethy/vim-illuminate',
		event = 'BufRead',
	},
	{
		'mcauley-penney/visual-whitespace.nvim',
		event = 'BufRead',
		config = true,
	},
	{
		'DanilaMihailov/beacon.nvim',
		event = 'BufRead',
		opts = {
			width = 20,
		},
	},
}
