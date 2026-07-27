---@type LazyPluginSpec
return {
	'saghen/blink.cmp',
	lazy = false,
	version = '1.*',
	build = 'cargo build --release',
	dependencies = {
		{ 'rafamadriz/friendly-snippets' },
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
			default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'emoji' },
			providers = {
				path = {
					opts = {
						get_cwd = function(_context)
							return vim.fn.getcwd()
						end,
					},
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
