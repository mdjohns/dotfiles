local js_linters = { 'eslint_d', 'oxlint' }

---@type LazyPluginSpec
return {
	'mfussenegger/nvim-lint',
	config = function()
		require('lint').linters_by_ft = {
			bash = { 'shellcheck' },
			javascript = js_linters,
			typescript = js_linters,
		}

		vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
			callback = function()
				pcall(require, 'lint.try_lint')
			end,
		})
	end,
}
