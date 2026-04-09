local grep_opts = {
	'rg',
	'--vimgrep',
	'--hidden',
	'--follow',
	'--glob',
	'!**/*.git/*',
	'--column',
	'--line-number',
	'--no-heading',
	'--color=always',
	'--smart-case',
	'--max-columns=4096',
	'-e',
}

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
				'<cmd>FzfLua grep<cr>',
				desc = 'grep',
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
			local actions = require 'fzf-lua.actions'
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
				grep = {
					cmd = table.concat(grep_opts, ' '),
					actions = {
						['ctrl-s'] = actions.toggle_hidden,
					},
				},
			}

			require('fzf-lua').register_ui_select()
		end,
	},
}
