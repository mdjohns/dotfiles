---@type LazyPluginSpec[]
return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = function()
			require('nvim-treesitter.install').update { with_sync = true }
		end,
		config = function()
			local configs = require 'nvim-treesitter.configs'

			---@diagnostic disable-next-line: missing-fields
			configs.setup {
				ensure_installed = {
					'astro',
					'css',
					'javascript',
					'lua',
					'make',
					'ocaml',
					'svelte',
					'toml',
					'typescript',
					'vim',
					'vimdoc',
					'yaml',
				},
				highlight = { enable = true },
				indent = { enable = true },
			}
		end,
	},
	{
		'davidmh/mdx.nvim',
		config = true,
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
	{
		'aaronik/treewalker.nvim',
		event = 'BufRead',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('treewalker').setup {
				highlight = true,
			}

			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			map('n', '<M-h>', ':Treewalker Left<CR>', opts)
			map('n', '<M-j>', ':Treewalker Down<CR>', opts)
			map('n', '<M-k>', ':Treewalker Up<CR>', opts)
			map('n', '<M-l>', ':Treewalker Right<CR>', opts)
		end,
	},
}
