vim.filetype.add {
	pattern = {
		-- dotfiles managed by `stow` will be prefixed with `dot-`
		-- for example, `.zshrc` will be `dot-zshrc`.
		-- this function replaces the `dot-`prefix with a `.` to allow neovim to properly resolve the filetype
		['dot-.*'] = function(_, _, ext)
			local actual_file_name = string.gsub(ext, 'dot%-(.*)', '.%1')
			vim.notify(actual_file_name, vim.log.levels.INFO)
			return vim.filetype.match { filename = actual_file_name }
		end,
	},
}
