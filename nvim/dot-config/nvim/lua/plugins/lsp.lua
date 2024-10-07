---@type LazyPluginSpec
return {
	'neovim/nvim-lspconfig',
	dependencies = {
		{ 'williamboman/mason.nvim' },
		{ 'williamboman/mason-lspconfig.nvim' },
		{ 'WhoIsSethDaniel/mason-tool-installer.nvim' },
		{ 'folke/neodev.nvim', ft = 'lua' },
		{ 'b0o/SchemaStore.nvim' },
	},
	config = function()
		require('mason').setup()
		local lspconfig = require 'lspconfig'
		local capabilities = nil
		if pcall(require, 'cmp_nvim_lsp') then
			capabilities = require('cmp_nvim_lsp').default_capabilities()
		end
		require('neodev').setup {}

		---@type table<string, boolean | table>
		local servers = {
			jsonls = {
				settings = {
					json = {
						schemas = require('schemastore').json.schemas(),
						validate = { enable = true },
					},
				},
			},
			lua_ls = true,
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
			'stylua',
			'prettierd',
			'eslint_d',
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
	end,
}
