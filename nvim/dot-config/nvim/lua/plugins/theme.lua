---@type LazyPluginSpec
return {
	'rose-pine/neovim',
	name = 'rose-pine',
	priority = 1000,
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require('rose-pine').setup {
			highlight_groups = {
				FzfLuaBorder = { fg = 'highlight_high', bg = 'none' },
				FzfLuaNormal = { bg = 'none' },
				FzfLuaFzfPrompt = { bg = 'base' },
				FzfLuaSearch = { fg = 'subtle', bg = 'none' },
				FzfLuaFzfPointer = { fg = 'rose', bg = 'rose' },
			},
		}

		vim.cmd.colorscheme 'rose-pine'
	end,
}
