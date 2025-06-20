---@type LazyPluginSpec
return {
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
}
