local js_linters = { 'eslint_d' }
return {
	'mfussenegger/nvim-lint',
	config = function()
		require('lint').linters_by_ft = {
			graphql = js_linters,
			javascript = js_linters,
			javascriptreact = js_linters,
			typescript = js_linters,
			typescriptreact = js_linters,
		}

		vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
			callback = function()
				if pcall(require, 'lint') then
					require('lint').try_lint()
				end
			end,
		})
	end,
}
