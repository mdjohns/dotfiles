---@type LazyPluginSpec
return {
	'folke/noice.nvim',
	event = 'VeryLazy',
	dependencies = {
		'MunifTanjim/nui.nvim',
		'rcarriga/nvim-notify',
	},
	keys = {
		{
			'<leader>nn',
			function()
				require('noice').cmd 'dismiss'
			end,
			desc = 'Dismiss Noice messages',
		},
		{
			'<leader>nl',
			function()
				require('noice').cmd 'last'
			end,
			desc = 'Show last Noice message',
		},
	},
	config = function()
		require('noice').setup {
			lsp = {
				hover = { enabled = false },
				signature = { enabled = false },
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
			},
			routes = {
				{
					filter = {
						event = 'lsp',
						kind = 'progress',
						cond = function(message)
							local client = vim.tbl_get(message.opts, 'progress', 'client')
							return client == 'lua_ls'
						end,
					},
					opts = { skip = true },
				},
			},
		}
	end,
}
