return {
	'mfussenegger/nvim-lint',
	config = function()
		require('lint').linters_by_ft = {}

		vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
			callback = function()
				if pcall(require, 'lint') then
					require('lint').try_lint()
				end
			end,
		})
	end,
}
