---@type LazyPluginSpec
return {
	'smjonas/inc-rename.nvim',
	opts = {},
	keys = {
		{
			'<leader>rn',
			function()
				return ':IncRename ' .. vim.fn.expand '<cword>'
			end,
			expr = true,
			desc = 'Rename word under cursor',
		},
	},
}
