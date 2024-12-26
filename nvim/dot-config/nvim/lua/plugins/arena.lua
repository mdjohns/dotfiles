---@type LazyPluginSpec
return {
	'dzfrias/arena.nvim',
	event = 'BufWinEnter',
	config = function()
		local map = vim.api.nvim_set_keymap
		local arena = require 'arena'
		arena.setup {}

		map('n', '<leader>aa', '', {
			desc = 'Toggle the Arena window',
			callback = function()
				arena.toggle()
			end,
		})
	end,
}
