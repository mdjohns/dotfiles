---@type LazyPluginSpec
return {
	'kylechui/nvim-surround',
	version = '*',
	event = 'VeryLazy',
	opts = {
		move_cursor = false,
	},
	config = true,
}
