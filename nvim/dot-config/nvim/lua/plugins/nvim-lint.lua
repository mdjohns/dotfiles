local js_linters = { 'eslint_d' }

---@type LazyPluginSpec
return {
	'mfussenegger/nvim-lint',
	config = function()
		require('lint').linters_by_ft = {
			astro = js_linters,
			bash = { 'shellcheck' },
			graphql = js_linters,
			sh = { 'shellcheck' },
			svelte = js_linters,
		}

		vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
			callback = function()
				pcall(require, 'lint.try_lint')
			end,
		})
	end,
}
