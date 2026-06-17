---@type LazyPluginSpec
return {
	enabled = false,
	'rose-pine/neovim',
	name = 'rose-pine',
	config = function()
		vim.cmd 'colorscheme rose-pine'
	end,
}
