---@type LazyPluginSpec[]
local themes = {
	{
		'rose-pine/neovim',
		name = 'rose-pine',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd 'colorscheme rose-pine'
		end,
	},
	{
		'vague-theme/vague.nvim',
		name = 'vague',
		lazy = false,
		priority = 1000,
		config = function()
			require('vague').setup {
				-- vague doesn't style nvim-notify, so its titles fall back to
				-- nvim-notify's loud defaults (INFO = bright green #A9FF68). Recolor.
				on_highlights = function(hl, c)
					hl.NotifyINFOTitle = { fg = c.constant }
					hl.NotifyWARNTitle = { fg = c.warning }
					hl.NotifyERRORTitle = { fg = c.error }
					hl.NotifyDEBUGTitle = { fg = c.comment }
					hl.NotifyTRACETitle = { fg = c.parameter }
				end,
			}
			vim.cmd.colorscheme 'vague'
		end,
	},
}

local active_theme = 'rose-pine'

local active_theme_spec = vim.tbl_filter(function(theme)
	return theme.name == active_theme
end, themes)

return active_theme_spec[1]
