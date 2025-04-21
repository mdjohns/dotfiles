---@type LazyPluginSpec[]
return {
	{
		'saghen/blink.cmp',
		lazy = false,
		build = 'cargo build --release',
		dependencies = {
			{ 'rafamadriz/friendly-snippets' },
			{ 'giuxtaposition/blink-cmp-copilot' },
			{
				'zbirenbaum/copilot.lua',
				cmd = 'Copilot',
				event = 'InsertEnter',
				opts = {
					panel = {
						enabled = false,
					},
					suggestion = {
						enabled = false,
					},
				},
				config = function(opts)
					require('copilot').setup(opts)
				end,
			},
		},
		---@type blink.cmp.Config
		opts = {
			cmdline = {
				completion = {
					menu = {
						auto_show = true,
					},
				},
				keymap = {
					preset = 'inherit',
				},
			},
			completion = {
				documentation = {
					window = {
						border = 'rounded',
					},
				},
				ghost_text = {
					enabled = true,
				},
				menu = {
					border = 'rounded',
					auto_show = function(_)
						return vim.bo.filetype ~= 'TelescopePrompt'
					end,
				},
			},
			keymap = {
				['<C-y>'] = { 'accept' },
				['<C-n>'] = { 'select_next' },
				['<C-p>'] = { 'select_prev' },
				['<C-j>'] = { 'snippet_forward' },
				['<C-k>'] = { 'snippet_backward' },
			},
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
				providers = {
					copilot = {
						name = 'copilot',
						module = 'blink-cmp-copilot',
						score_offset = 100,
						async = true,
					},
				},
			},
		},
		config = true,
	},
}
