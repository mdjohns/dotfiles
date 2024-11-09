---@type LazyPluginSpec
return {
	'neovim/nvim-lspconfig',
	dependencies = {
		{ 'williamboman/mason.nvim' },
		{ 'williamboman/mason-lspconfig.nvim' },
		{ 'WhoIsSethDaniel/mason-tool-installer.nvim' },
		{ 'folke/neodev.nvim', ft = 'lua' },
		{ 'b0o/SchemaStore.nvim' },
		{ 'Saghen/blink.cmp' },
	},
	config = function()
		require('mason').setup()
		local lspconfig = require 'lspconfig'
		local capabilities = nil
		if pcall(require, 'blink-cmp') then
			capabilities = require('blink-cmp').get_lsp_capabilities()
		end
		require('neodev').setup {}

		---@type table<string, boolean | table>
		local servers = {
			bashls = true,
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
			graphql = true,
			lua_ls = true,
			marksman = true,
			svelte = true,
			rust_analyzer = true,
			vtsls = true,
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
			'bashls',
			'biome',
			'eslint_d',
			'jsonls',
			'prettierd',
			'stylua',
			'svelte-language-server',
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
				vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = 0 })
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0 })
				vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { buffer = 0 })
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
				vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = 0 })
				vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0 })
			end,
		})
	end,
}
