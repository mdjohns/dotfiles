local js_formatters = { 'eslint_d', 'oxfmt', 'prettierd' }

---@type LazyPluginSpec
return {
	'stevearc/conform.nvim',
	opts = {},
	config = function()
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
			'.eslintrc.json',
			'.eslintrc.yml',
			'.eslintrc.yaml',
			'.eslintrc.json5',
			'.eslintrc.js',
			'.eslintrc.cjs',
			'.eslintrc.mjs',
			'eslint.config.mjs',
			'eslint.config.js',
		}

		require('conform').setup {
			formatters_by_ft = {
				javascript = js_formatters,
				javascriptreact = js_formatters,
				json = { 'prettierd' },
				jsonc = { 'prettierd' },
				lua = { 'stylua' },
				markdown = { 'prettierd', 'injected' },
				python = { 'ruff' },
				typescript = js_formatters,
				typescriptreact = js_formatters,
			},
			format_on_save = {
				timeout_ms = 1000,
				lsp_format = 'fallback',
			},
			formatters = {
				eslint_d = {
					cwd = function(self, ctx)
						-- only use eslint for formatting if prettier is not configured
						if not prettier_cwd(self, ctx) then
							return eslint_cwd(self, ctx)
						end
					end,
					require_cwd = true,
				},
				oxfmt = {
					cwd = function(self, ctx)
						local oxfmt_config = require('conform.util').root_file {
							'.oxfmtrc.json',
							'.oxfmtrc.jsonc',
							'oxfmt.config.ts',
						}

						return oxfmt_config(self, ctx)
					end,
					require_cwd = true,
				},
				prettierd = {
					cwd = function(self, ctx)
						local is_markdown = vim.bo.filetype == 'markdown'
						if is_markdown then
							return ctx.dirname
						end

						return prettier_cwd(self, ctx)
					end,
					require_cwd = true,
				},
			},
		}
	end,
}
