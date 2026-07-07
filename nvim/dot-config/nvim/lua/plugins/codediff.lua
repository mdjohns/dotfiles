---@type LazyPluginSpec
return {
	'esmuellert/codediff.nvim',
	cmd = 'CodeDiff',
	config = function()
		require('codediff').setup {
			diff = {
				compute_moves = true,
				layout = 'inline',
			},
		}
	end,
}
