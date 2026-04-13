---@type LazyPluginSpec
return {
	'folke/snacks.nvim',
	opts = {},
	keys = {
		{
			'<leader><leader>',
			function()
				require('snacks').picker.smart()
			end,
			desc = 'Smart Find Files',
		},
		{
			'<leader>ff',
			function()
				if vim.fn.isdirectory '.git' == 1 then
					require('snacks').picker.git_files()
				else
					require('snacks').picker.files()
				end
			end,
			desc = 'Find Files',
		},
		{
			'<leader>fg',
			function()
				require('snacks').picker.grep()
			end,
			desc = 'Grep',
		},
		{
			'<leader>fh',
			function()
				require('snacks').picker.help()
			end,
			desc = 'Find Help docs',
		},
	},
}
