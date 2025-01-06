---@type LazyPluginSpec
return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
		},
		{
			'nvim-telescope/telescope-frecency.nvim',
		},
	},
	lazy = false,
	keys = {
		{
			'<leader><leader>',
			'<cmd>Telescope git_files path_display={"filename_first"} theme=dropdown<cr>',
			desc = 'Git Files',
		},
		{
			'<leader>ff',
			'<cmd>Telescope frecency workspace=CWD path_display={"filename_first"} theme=dropdown<cr>',
			desc = 'Find Frecent Files',
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
		{
			'gr',
			'<cmd>Telescope lsp_references show_line=false<cr>',
			desc = 'Find LSP references',
		},
	},
	config = function()
		local telescope = require 'telescope'
		telescope.setup {
			defaults = {
				dynamic_preview_title = true,
				path_display = { 'filename_first' },
			},
		}
		telescope.load_extension 'fzf'
		telescope.load_extension 'frecency'

		local actions = require 'telescope.actions'

		vim.keymap.set('n', '<C-n>', function()
			local bufnr = vim.api.nvim_get_current_buf()
			actions.move_selection_next(bufnr)
		end)

		vim.keymap.set('n', '<C-p>', function()
			local bufnr = vim.api.nvim_get_current_buf()
			actions.move_selection_previous(bufnr)
		end)
	end,
}
