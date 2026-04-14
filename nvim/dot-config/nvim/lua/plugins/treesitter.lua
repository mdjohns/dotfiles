return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',
	config = function()
		local ts = require 'nvim-treesitter'
		local parsers = {
			'bash',
			'css',
			'comment',
			'dockerfile',
			'diff',
			'git_config',
			'gitcommit',
			'gitignore',
			'html',
			'http',
			'javascript',
			'jsdoc',
			'json',
			'json5',
			'lua',
			'markdown',
			'markdown_inline',
			'terraform',
			'toml',
			'tsx',
			'typescript',
			'vim',
			'vimdoc',
			'yaml',
		}

		for _, parser in ipairs(parsers) do
			ts.install(parser)
		end

		local patterns = {}
		for _, parser in ipairs(parsers) do
			local parser_patterns = vim.treesitter.language.get_filetypes(parser)

			for _, pattern in ipairs(parser_patterns) do
				table.insert(patterns, pattern)
			end
		end

		vim.api.nvim_create_autocmd('FileType', {
			pattern = patterns,
			callback = function()
				-- highlighting
				vim.treesitter.start()
				-- indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				-- folds
				vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
				vim.wo[0][0].foldmethod = 'expr'
			end,
		})
	end,
}
