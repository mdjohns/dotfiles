---@type LazyPluginSpec
return {
	'mfussenegger/nvim-lint',
	config = function()
		require('lint').linters_by_ft = {
			bash = { 'shellcheck' },
		}

		vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
			callback = function()
				require('lint').try_lint()
			end,
		})
	end,
}
