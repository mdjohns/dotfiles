return {
	---@type LazyPluginSpec
	{
		'saghen/blink.cmp',
		lazy = false,
		build = 'cargo build --release',
		opts = {
			keymap = {
				accept = '<C-y>',
				select_next = '<C-n>',
				select_prev = '<C-p>',
			},
			windows = {
				autocomplete = {
					border = 'rounded',
				},
			},
		},
		config = true,
	},
	---@type LazyPluginSpec
	{
		enabled = false,
		'iguanacucumber/magazine.nvim',
		dependencies = {
			{ 'neovim/nvim-lspconfig' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-cmdline' },
			{ 'onsails/lspkind.nvim' },
		},
		config = function()
			local cmp = require 'cmp'
			local lspkind = require 'lspkind'

			cmp.setup {
				formatting = {
					format = lspkind.cmp_format {
						mode = 'symbol_text',
						maxwidth = 50,
						ellipsis_char = '...',
						show_labelDetails = true,
					},
				},
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert {
					['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
					['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
					['<C-y>'] = cmp.mapping(
						cmp.mapping.confirm {
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						},
						{ 'i', 'c' }
					),
				},
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'path' },
					{ name = 'buffer' },
				},
			}
		end,
	},
}
