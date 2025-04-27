---@type LazyPluginSpec[]
return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },
			{ 'WhoIsSethDaniel/mason-tool-installer.nvim' },
			{ 'folke/neodev.nvim', ft = 'lua' },
			{ 'b0o/SchemaStore.nvim' },
			{ 'Saghen/blink.cmp' },
			{
				'marilari88/twoslash-queries.nvim',
				ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
				opts = {
					highlight = 'EndOfBuffer',
				},
			},
		},
		config = function()
			require('mason').setup()
			local lspconfig = require 'lspconfig'
			local capabilities = nil
			if pcall(require, 'blink-cmp') then
				capabilities = require('blink-cmp').get_lsp_capabilities()
			end
			require('neodev').setup {}

			vim.diagnostic.config { virtual_text = true }

			---@type table<string, boolean | table>
			local servers = {
				astro = true,
				bashls = true,
				graphql = true,
				jsonls = {
					settings = {
						json = {
							schemas = require('schemastore').json.schemas(),
							validate = { enable = true },
						},
						yaml = {
							schemas = require('schemastore').yaml.schemas(),
							validate = { enable = true },
						},
					},
				},
				lua_ls = true,
				marksman = true,
				ocamllsp = {
					manual_install = true,
					settings = {
						codelens = { enable = true },
						inlayHints = { enable = true },
					},
				},
				svelte = true,
				taplo = true,
				rust_analyzer = true,
				vtsls = {
					on_attach = function(client, bufnr)
						require('twoslash-queries').attach(client, bufnr)
					end,
				},
				yamlls = true,
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == 'table' then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			local ensure_installed = {
				'astro',
				'bashls',
				'biome',
				'eslint_d',
				'jsonls',
				'prettierd',
				'stylua',
				'svelte-language-server',
				'taplo',
				'yaml-language-server',
			}
			vim.list_extend(ensure_installed, servers_to_install)

			require('mason-tool-installer').setup { ensure_installed = ensure_installed }

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend('force', {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client:supports_method 'textDocument/documentColor' then
						vim.lsp.document_color.enable(true, args.buf, {
							style = 'virtual',
						})
					end

					vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
					vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = 0 })
					vim.keymap.set('n', '<leader>ca', require('fzf-lua').lsp_code_actions, { buffer = 0 })
					vim.keymap.set('n', '<leader>x', vim.diagnostic.open_float, { buffer = 0 })
				end,
			})
		end,
	},
	{
		'rachartier/tiny-inline-diagnostic.nvim',
		event = 'LspAttach',
		priority = 1000, -- needs to be loaded in first
		config = function()
			require('tiny-inline-diagnostic').setup()
		end,
	},
}
