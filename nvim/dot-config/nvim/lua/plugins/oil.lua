---@type LazyPluginSpec
return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
	lazy = false,
	config = function()
		require('oil').setup {
			git = {
				mv = function()
					return true
				end,
			},
			keymaps = {
				['<leader>y'] = {
					'actions.yank_entry',
					desc = 'Yank file path',
				},
				['<leader>Y'] = {
					function()
						require('oil.actions').yank_entry.callback()
						vim.fn.setreg('+', vim.fn.getreg('"'))
					end,
					desc = 'Copy file path to system clipboard',
				},
			},
		}
		vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
	end,
}
