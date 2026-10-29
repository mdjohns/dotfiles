---@type LazyPluginSpec
return {
	'esmuellert/codediff.nvim',
	cmd = 'CodeDiff',
	config = function()
		require('codediff').setup {
			diff = {
				compute_moves = true,
				layout = 'inline',
			},
		}

		local group = vim.api.nvim_create_augroup('CodeDiffDisableFolds', { clear = true })

		local function disable_folds_in_tab(tabpage)
			if not tabpage or not vim.api.nvim_tabpage_is_valid(tabpage) then
				return
			end
			for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
				vim.wo[win].foldenable = false
			end
		end

		vim.api.nvim_create_autocmd('User', {
			group = group,
			pattern = { 'CodeDiffOpen', 'CodeDiffFileSelect' },
			callback = function(ev)
				local tabpage = ev.data and ev.data.tabpage or vim.api.nvim_get_current_tabpage()
				disable_folds_in_tab(tabpage)
				vim.schedule(function()
					disable_folds_in_tab(tabpage)
				end)
			end,
		})

		vim.api.nvim_create_autocmd({ 'BufWinEnter', 'FileType' }, {
			group = group,
			callback = function()
				local tabpage = vim.api.nvim_get_current_tabpage()
				local ok, lifecycle = pcall(require, 'codediff.ui.lifecycle')
				if ok and lifecycle.get_session(tabpage) then
					vim.wo[0].foldenable = false
				end
			end,
		})
	end,
}
