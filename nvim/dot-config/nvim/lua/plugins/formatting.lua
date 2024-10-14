local js_formatters = { 'biome', 'eslint_d', 'prettierd' }

---@type LazyPluginSpec
return {
	'stevearc/conform.nvim',
	event = { 'BufWritePre' },
	cmd = { 'ConformInfo' },
	config = function()
		-- same as the configuration from the plugin, minus `package.json` as we want to be more specific
		local prettier_cwd = require('conform.util').root_file {
			'.prettierrc',
			'.prettierrc.json',
			'.prettierrc.yml',
			'.prettierrc.yaml',
			'.prettierrc.json5',
			'.prettierrc.js',
			'.prettierrc.cjs',
			'.prettierrc.mjs',
			'.prettierrc.toml',
			'prettier.config.js',
			'prettier.config.cjs',
			'prettier.config.mjs',
		}

		local eslint_cwd = require('conform.util').root_file {
			'.eslintrc',
			'.eslintrc.js',
			'.eslintrc.cjs',
			'.eslintrc.mjs',
			'.eslintrc.json',
			'eslint.config.js',
		}

		require('conform').setup {
			formatters_by_ft = {
				lua = { 'stylua' },
				javascript = js_formatters,
				javascriptreact = js_formatters,
				typescript = js_formatters,
				typescriptreact = js_formatters,
			},
			format_on_save = { timeout_ms = 5000, lsp_format = 'fallback' },
			formatters = {
				biome = {
					require_cwd = true,
				},
				eslint_d = {
					cwd = function(self, ctx)
						if not prettier_cwd(self, ctx) then
							return eslint_cwd(self, ctx)
						end
					end,
					require_cwd = true,
				},
				prettierd = {
					cwd = prettier_cwd,
					require_cwd = true,
				},
			},
		}
	end,
}
