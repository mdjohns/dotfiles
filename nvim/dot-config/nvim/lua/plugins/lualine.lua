local lsp_utils = require 'my.utils.lsp'

return {
	'nvim-lualine/lualine.nvim',
	event = { 'VimEnter', 'BufReadPost', 'BufNewFile' },
	dependencies = {
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
		local lualine = require 'lualine'

		local attached_clients = {
			lsp_utils.get_attached_clients,
			color = {
				gui = 'bold',
			},
		}

		lualine.setup {
			theme = 'rose-pine',
			sections = {
				lualine_b = { 'branch', 'diff' },
				lualine_c = {
					{
						'filename',
						path = 1,
						shorting_target = 40,
					},
				},
				lualine_x = {
					'diagnostics',
					attached_clients,
					-- { require 'mcphub.extensions.lualine' },
					'filetype',
				},
			},
		}
	end,
}
