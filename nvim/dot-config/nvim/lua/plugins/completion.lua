---@type LazyPluginSpec[]
return {
	{
		'saghen/blink.cmp',
		lazy = false,
		build = 'cargo build --release',
		dependencies = { 'rafamadriz/friendly-snippets' },
		---@type blink.cmp.Config
		opts = {
			---@diagnostic disable: missing-fields
			completion = {
				documentation = {
					window = {
						border = 'rounded',
					},
				},
				menu = {
					border = 'rounded',
					auto_show = function(_)
						return vim.bo.filetype ~= 'TelescopePrompt'
					end,
				},
			},
			---@diagnostic enable: missing-fields
			keymap = {
				['<C-y>'] = { 'accept' },
				['<C-n>'] = { 'select_next' },
				['<C-p>'] = { 'select_prev' },
				['<C-j>'] = { 'snippet_forward' },
				['<C-k>'] = { 'snippet_backward' },
			},
		},
		config = true,
	},
}
