local M = {}

-- credit: https://gist.github.com/Lamarcke/36e086dd3bb2cebc593d505e2f838e07
-- Returns a string with a list of attached LSP clients
M.get_attached_clients = function()
	local buf_clients = vim.lsp.get_clients { bufnr = 0 }
	if #buf_clients == 0 then
		return 'LSP Inactive'
	end

	local buf_ft = vim.bo.filetype
	local buf_client_names = {}

	-- add LSP client
	for _, client in pairs(buf_clients) do
		if client.name ~= 'copilot' and client.name ~= 'null-ls' then
			table.insert(buf_client_names, client.name)
		end
	end

	-- Add linters (from nvim-lint)
	local lint_s, lint = pcall(require, 'lint')
	if lint_s then
		for ft_k, ft_v in pairs(lint.linters_by_ft) do
			if type(ft_v) == 'table' then
				for _, linter in ipairs(ft_v) do
					if buf_ft == ft_k then
						table.insert(buf_client_names, linter)
					end
				end
			elseif type(ft_v) == 'string' then
				if buf_ft == ft_k then
					table.insert(buf_client_names, ft_v)
				end
			end
		end
	end

	-- Add formatters (from conform.nvim)
	local conform_available, _ = pcall(require, 'conform')
	if conform_available then
		local conform = require 'conform'
		for _, formatter in ipairs(conform.list_formatters_to_run(vim.api.nvim_get_current_buf())) do
			if formatter then
				table.insert(buf_client_names, formatter.name)
			end
		end
	end

	-- This needs to be a string only table so we can use concat below
	local unique_client_names = {}
	for _, client_name_target in ipairs(buf_client_names) do
		local is_duplicate = false
		for _, client_name_compare in ipairs(unique_client_names) do
			if client_name_target == client_name_compare then
				is_duplicate = true
			end
		end
		if not is_duplicate then
			table.insert(unique_client_names, client_name_target)
		end
	end

	local client_names_str = table.concat(unique_client_names, ', ')
	local language_servers = string.format('[%s]', client_names_str)

	return language_servers
end

return M
