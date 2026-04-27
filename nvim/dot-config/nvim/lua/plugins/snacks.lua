---@type LazyPluginSpec
return {
	'folke/snacks.nvim',
	---@type snacks.Config
	opts = {
		bigfile = {},
		indent = {},
		input = {},
	},
	keys = {
		{
			'<leader><leader>',
			function()
				require('snacks.picker').smart()
			end,
			desc = 'Smart Find Files',
		},
		{
			'<leader>ff',
			function()
				if vim.fn.isdirectory '.git' == 1 then
					require('snacks.picker').git_files()
				else
					require('snacks.picker').files()
				end
			end,
			desc = 'Find Files',
		},
		{
			'<leader>fg',
			function()
				require('snacks.picker').grep()
			end,
			desc = 'Grep',
		},
		{
			'<leader>fh',
			function()
				require('snacks.picker').help()
			end,
			desc = 'Find Help docs',
		},

		{
			'<leader>sd',
			function()
				require('snacks.picker').diagnostics()
			end,
			desc = 'Diagnostics',
		},
		{
			'<leader>sD',
			function()
				require('snacks.picker').diagnostics_buffer()
			end,
			desc = 'Buffer Diagnostics',
		},
		{
			'gd',
			function()
				require('snacks.picker').lsp_definitions()
			end,
			desc = 'Goto Definition',
		},
		{
			'gD',
			function()
				require('snacks.picker').lsp_declarations()
			end,
			desc = 'Goto Declaration',
		},
		{
			'gr',
			function()
				require('snacks.picker').lsp_references()
			end,
			nowait = true,
			desc = 'References',
		},
		{
			'gI',
			function()
				require('snacks.picker').lsp_implementations()
			end,
			desc = 'Goto Implementation',
		},
		{
			'gy',
			function()
				require('snacks.picker').lsp_type_definitions()
			end,
			desc = 'Goto T[y]pe Definition',
		},
		{
			'gai',
			function()
				require('snacks.picker').lsp_incoming_calls()
			end,
			desc = 'C[a]lls Incoming',
		},
		{
			'gao',
			function()
				require('snacks.picker').lsp_outgoing_calls()
			end,
			desc = 'C[a]lls Outgoing',
		},
		{
			'<leader>ss',
			function()
				require('snacks.picker').lsp_symbols()
			end,
			desc = 'LSP Symbols',
		},
		{
			'<leader>sS',
			function()
				require('snacks.picker').lsp_workspace_symbols()
			end,
			desc = 'LSP Workspace Symbols',
		},
	},
}
