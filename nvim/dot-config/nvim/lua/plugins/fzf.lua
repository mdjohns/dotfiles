---@type LazyPluginSpec[]
return {
	{
		'ibhagwan/fzf-lua',
		dependencies = { 'echasnovski/mini.icons' },
		keys = {
			{
				'<leader><leader>',
				function()
					local fzf = require 'fzf-lua'
					local git_files = fzf.git_files
					local files = fzf.files

					function FILES(query)
						files {
							query = query or '',
							actions = {
								['ctrl-g'] = {
									fn = function(_, opts)
										GIT_FILES(opts.last_query)
									end,
									exec_silent = true,
								},
							},
						}
					end

					function GIT_FILES(query)
						git_files {
							['query'] = query or '',
							actions = {
								['ctrl-g'] = {
									fn = function(_, opts)
										FILES(opts.last_query)
									end,
									exec_silent = true,
								},
							},
						}
					end

					GIT_FILES()
				end,
				desc = 'Toggle between git files and all files',
			},
			{
				'<leader>fh',
				'<cmd>FzfLua helptags<cr>',
				desc = 'Find helptags',
			},
			{
				'<leader>fg',
				'<cmd>FzfLua live_grep_glob<cr>',
				desc = 'Live grep',
			},
			{
				'<leader>fw',
				'<cmd>FzfLua grep_cword<cr>',
				desc = 'Find word under cursor',
			},
			{
				'gd',
				'<cmd>FzfLua lsp_definitions<cr>',
			},
			{
				'gr',
				'<cmd>FzfLua lsp_references<cr>',
			},
		},
		config = function()
			require('fzf-lua').setup {
				'fzf-native',
				files = {
					formatter = 'path.filename_first',
				},
				git = {
					files = {
						formatter = 'path.filename_first',
					},
				},
				lsp = {
					definitions = {
						jump1 = true,
					},
					references = {
						jump1 = true,
					},
				},
			}

			require('fzf-lua').register_ui_select()
		end,
	},
}
