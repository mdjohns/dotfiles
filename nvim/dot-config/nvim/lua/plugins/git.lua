return {
	---@type LazyPluginSpec
	{
		'lewis6991/gitsigns.nvim',
		event = 'BufRead',
		opts = {
			current_line_blame = true,
		},
	},
	---@type LazyPluginSpec
	{
		'kdheepak/lazygit.nvim',
		lazy = true,
		cmd = {
			'LazyGit',
			'LazyGitConfig',
			'LazyGitCurrentFile',
			'LazyGitFilter',
			'LazyGitFilterCurrentFile',
		},
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		keys = {
			{ '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
		},
	},
}
