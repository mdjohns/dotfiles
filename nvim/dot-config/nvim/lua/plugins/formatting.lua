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
			'eslint.config.mjs',
		}

		vim.api.nvim_create_user_command('FormatDisable', function(args)
			if args.bang then
				-- FormatDisable! to disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				-- Otherwise disable it globally
				vim.g.disable_autoformat = true
			end
		end, {
			desc = 'Disable format on save',
			bang = true,
		})

		vim.api.nvim_create_user_command('FormatEnable', function()
			vim.g.disable_autoformat = true
			vim.b.disable_autoformat = true
		end, {
			desc = 'Re-enable format on save',
			bang = true,
		})

		require('conform').setup {
			formatters_by_ft = {
				astro = js_formatters,
				bash = { 'shfmt' },
				graphql = js_formatters,
				lua = { 'stylua' },
				javascript = js_formatters,
				javascriptreact = js_formatters,
				markdown = { 'injected' },
				ocaml = { 'ocamlformat' },
				sh = { 'shfmt' },
				svelte = js_formatters,
				typescript = js_formatters,
				typescriptreact = js_formatters,
				yaml = { 'prettierd' },
			},
			format_on_save = function(bufnr)
				-- Disable formatting on save with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 1000, lsp_format = 'fallback' }
			end,
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
