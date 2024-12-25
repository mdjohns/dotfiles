return {
	---@type LazyPluginSpec
	{
		'saghen/blink.cmp',
		lazy = false,
		build = 'cargo build --release',
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
			sources = {
				cmdline = function()
					local type = vim.fn.getcmdtype()
					-- Searching forward or backwards
					if type == '/' or type == '?' then
						return { 'buffer' }
					end
					-- Command
					if type == ':' then
						return { 'cmdline' }
					end
					return {}
				end,
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
