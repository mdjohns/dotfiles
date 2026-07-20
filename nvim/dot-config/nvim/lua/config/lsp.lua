vim.lsp.enable {
	'basedpyright',
	'gopls',
	'lua_ls',
	'jsonls',
	'terraformls',
	'vtsls',
	'yamlls',
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

vim.keymap.set('n', '<leader>x', vim.diagnostic.open_float, { desc = 'Open diagnostics float' })
