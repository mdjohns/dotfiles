local job_id = nil

vim.api.nvim_buf_create_user_command(0, 'MarkdownPreview', function(opts)
	local subcmd = opts.fargs[1]

	if subcmd == 'start' then
		if job_id then
			vim.notify('Markdown preview already running', vim.log.levels.WARN)
			return
		end
		job_id = vim.fn.jobstart({ 'gh', 'markdown-preview', vim.api.nvim_buf_get_name(0) }, {
			detach = true,
			on_exit = function()
				job_id = nil
			end,
		})
	elseif subcmd == 'stop' then
		if not job_id then
			vim.notify('No markdown preview running', vim.log.levels.WARN)
			return
		end
		vim.fn.jobstop(job_id)
		job_id = nil
	else
		vim.notify('Usage: MarkdownPreview start|stop', vim.log.levels.ERROR)
	end
end, {
	nargs = 1,
	complete = function()
		return { 'start', 'stop' }
	end,
})
