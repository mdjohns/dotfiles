---@type LazyPluginSpec
return {
	'mvllow/modes.nvim',
	config = true,
	event = { 'VimEnter', 'BufReadPost', 'BufNewFile' },
}
