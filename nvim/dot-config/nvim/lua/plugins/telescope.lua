return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
		},
	},
	tag = '0.1.8',
	opts = {
		layout_strategy = 'vertical',
		pickers = {
			find_files = {
				file_ignore_patterns = { 'node_modules', '.git' },
				hidden = true,
			},
			live_grep = {
				file_ignore_patterns = { 'node_modules', '.git' },
				hidden = true,
			},
		},
		extensions = {
			menufacture = {
				mappings = {
					toggle_hidden = { i = '<C-.>' },
				},
			},
		},
	},
	keys = {
		{
			'<leader>ff',
			'<cmd>Telescope find_files theme=dropdown<cr>',
			desc = 'Find Files',
		},
		{
			'<leader>fg',
			'<cmd>Telescope live_grep theme=dropdown<cr>',
			desc = 'Find Files',
		},
		{
			'<leader>fh',
			'<cmd>Telescope help_tags theme=dropdown<cr>',
			desc = 'Find Files',
		},
	},
	config = function(opts)
		local telescope = require 'telescope'
		telescope.setup(opts)
		telescope.load_extension 'fzf'
	end,
}
