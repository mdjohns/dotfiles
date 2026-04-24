---@type LazyPluginSpec
return {
	'saghen/blink.cmp',
	lazy = false,
	version = '1.*',
	build = 'cargo build --release',
	dependencies = {
		{ 'rafamadriz/friendly-snippets' },
		{ 'giuxtaposition/blink-cmp-copilot' },
		{ 'zbirenbaum/copilot.lua' },
		{ 'folke/lazydev.nvim' },
		{ 'moyiz/blink-emoji.nvim' },
	},
	opts = {
		completion = {
			menu = {
				draw = {
					treesitter = { 'lsp' },
				},
			},
		},
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'lazydev', 'emoji' },
			providers = {
				path = {
					opts = {
						get_cwd = function(_context)
							return vim.fn.getcwd()
						end,
					},
				},
				copilot = {
					name = 'copilot',
					module = 'blink-cmp-copilot',
					score_offset = 100,
					async = true,
				},
				lazydev = {
					module = 'lazydev.integrations.blink',
					score_offset = 100,
				},
				emoji = {
					module = 'blink-emoji',
					score_offset = 15,
				},
			},
		},
		signature = {
			enabled = true,
		},
	},
}
