---@type LazyPluginSpec
return {
	'olimorris/codecompanion.nvim',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-treesitter/nvim-treesitter' },
		{ 'ravitemer/mcphub.nvim' },
		{ 'ravitemer/codecompanion-history.nvim' },
		{ 'j-hui/fidget.nvim' },
	},
	config = function()
		require('codecompanion').setup {
			display = {
				window = {
					full_height = true,
					position = 'right',
					width = 0.4,
				},
			},
			extensions = {
				history = {
					enabled = true,
					opts = {
						auto_save = true,
						auto_generate_title = true,
						continue_last_chat = true,
						dir_to_save = vim.fn.stdpath 'data' .. '/codecompanion_history',
						keymap = 'gh',
						picker = 'default',
						save_chat_keymap = 'sc',
					},
				},
				mcphub = {
					callback = 'mcphub.extensions.codecompanion',
					log_level = 'ERROR',
					opts = {
						show_result_in_chat = false,
						make_vars = true,
						make_slash_commands = true,
					},
				},
			},
		}

		vim.keymap.set({ 'n', 'v' }, '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
		vim.keymap.set({ 'n', 'v' }, '<leader>a', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
		vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })

		-- Expand 'cc' into 'CodeCompanion' in the command line
		vim.cmd [[cab cc CodeCompanion]]
	end,
}
