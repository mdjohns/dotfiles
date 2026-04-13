---@type LazyPluginSpec
return {
	'mvllow/modes.nvim',
	event = { 'VimEnter', 'BufReadPost', 'BufNewFile' },
	config = function()
		require('modes').setup()
	end,
}
