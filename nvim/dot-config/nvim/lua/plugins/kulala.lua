---@type LazyPluginSpec
return {
	'mistweaverco/kulala.nvim',
	keys = {
		{
			'<leader>kk',
			function()
				require('kulala').run()
			end,
			desc = 'Send HTTP request',
		},
		{
			'<leader>ka',
			function()
				require('kulala').run_all()
			end,
			desc = 'Send all HTTP requests in the current buffer',
		},
		{
			'<leader>kp',
			function()
				require('kulala').scratchpad()
			end,
			desc = 'Open Kulala scratchpad',
		},
	},
	ft = { 'http', 'rest' },
	opts = {
		additional_curl_options = { '--insecure' },
		global_keymaps = false,
		lsp = {
			keymaps = true,
		},
	},
}
