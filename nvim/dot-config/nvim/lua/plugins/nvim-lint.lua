---@type LazyPluginSpec
return {
	'mfussenegger/nvim-lint',
	config = function()
		require('lint').linters_by_ft = {
			bash = { 'shellcheck' },
			python = { 'ruff' },
		}

		vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
			callback = function()
				local ok, lint = pcall(require, 'lint')
				if not ok then
					return
				end

				lint.try_lint()
			end,
		})
	end,
}
