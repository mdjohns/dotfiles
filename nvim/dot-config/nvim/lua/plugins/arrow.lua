--- @type LazyPluginSpec
return {
	'otavioschwanck/arrow.nvim',
	dependencies = {
		{ 'nvim-tree/nvim-web-devicons' },
	},
	keys = {
		';',
	},
	opts = {
		show_icons = true,
		leader_key = ';',
		buffer_leader_key = 'm',
	},
}
