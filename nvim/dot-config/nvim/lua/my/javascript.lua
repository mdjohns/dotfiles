local M = {}
local api = vim.api

local valid_configs = {
	'.eslintrc',
	'.eslintrc.js',
	'.eslintrc.cjs',
	'.eslintrc.mjs',
	'.eslintrc.json',
	'eslint.config.js',
	'eslint.config.mjs',
}

local get_eslint_config = function()
	for _, config in ipairs(valid_configs) do
		local resolved_path = vim.uv.cwd() .. '/' .. config
		if vim.uv.fs_stat(resolved_path) then
			return resolved_path
		end
	end
	return nil
end

local lint_if_enabled = function()
	local config = get_eslint_config()
	if config ~= nil then
		local bufnr = api.nvim_get_current_buf()

		vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufEnter', 'BufWritePost' }, {
			buffer = bufnr,
			group = api.nvim_create_augroup('eslint-' .. bufnr, { clear = true }),
			callback = function()
				require('lint.linters.eslint_d').config_file = config
				require('lint').try_lint 'eslint_d'
			end,
		})
	end
end

M.apply_common_settings = function()
	lint_if_enabled()
end

return M
