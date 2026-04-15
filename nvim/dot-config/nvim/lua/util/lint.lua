local M = {}

local configs = {
	eslint_d = {
		'.eslintrc',
		'.eslintrc.json',
		'.eslintrc.yml',
		'.eslintrc.yaml',
		'.eslintrc.js',
		'.eslintrc.cjs',
		'.eslintrc.mjs',
		'eslint.config.mjs',
		'eslint.config.js',
	},
	oxlint = {
		'.oxlintrc.json',
		'oxlint.config.ts',
	},
	biome = {
		'biome.json',
		'biome.jsonc',
	},
}

--- Conditionally enable a linter for the current buffer if a config file exists.
---@param name string
function M.enable_if_configured(name)
	local patterns = configs[name]
	if not patterns then
		return
	end

	if not vim.fn.executable(name) then
		return
	end

	local found = vim.fs.find(patterns, { upward = true, path = vim.uv.cwd() })[1]
	if not found then
		return
	end

	local bufnr = vim.api.nvim_get_current_buf()

	local linters = vim.b[bufnr].ftplugin_linters or {}
	table.insert(linters, name)
	vim.b[bufnr].ftplugin_linters = linters

	vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
		buffer = bufnr,
		group = vim.api.nvim_create_augroup(name .. '-' .. bufnr, { clear = true }),
		callback = function()
			require('lint').try_lint(name)
		end,
	})
end

return M
