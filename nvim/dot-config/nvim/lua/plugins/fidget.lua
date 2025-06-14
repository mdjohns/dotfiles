---@type LazyPluginSpec
return {
	'j-hui/fidget.nvim',
	opts = {
		notification = {
			override_vim_notify = true,
		},
	},
	dependencies = { 'neovim/nvim-lspconfig' },
	event = { 'VimEnter', 'BufReadPost', 'BufNewFile' },
}
