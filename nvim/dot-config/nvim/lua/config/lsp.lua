vim.lsp.enable {
	'copilot',
	'lua_ls',
	'jsonls',
	'vtsls',
}

vim.diagnostic.config {
	float = {
		border = 'rounded',
		source = true,
	},
	severity_sort = true,
	underline = true,
	virtual_lines = true,
	virtual_text = true,
}
