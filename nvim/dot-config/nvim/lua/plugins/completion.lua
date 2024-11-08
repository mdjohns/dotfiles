return {
	---@type LazyPluginSpec
	{
		'saghen/blink.cmp',
		lazy = false,
		build = 'cargo build --release',
		---@type blink.cmp.Config
		opts = {
			keymap = {
				['<C-y>'] = { 'accept' },
				['<C-n>'] = { 'select_next' },
				['<C-p>'] = { 'select_prev' },
				['<C-j>'] = { 'snippet_forward' },
				['<C-k>'] = { 'snippet_backward' },
			},
			windows = {
				autocomplete = {
					border = 'rounded',
				},
			},
		},
		config = true,
	},
}
