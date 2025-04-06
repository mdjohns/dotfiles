---@type LazyPluginSpec[]
return {
	{
		'ibhagwan/fzf-lua',
		dependencies = { 'echasnovski/mini.icons' },
		keys = {
			{
				'<leader><leader>',
				function()
					local function toggle_git_files()
						require('fzf-lua').git_files {
							actions = {
								['ctrl-g'] = {
									fn = function()
										require('fzf-lua').files {
											actions = {
												['ctrl-g'] = {
													fn = toggle_git_files,
													exec_silent = true,
												},
											},
										}
									end,
									exec_silent = true,
								},
							},
						}
					end
					toggle_git_files()
				end,
				desc = 'Find git files',
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
		end,
	},
}
