local job_id = nil
local max_error_chars = 50

vim.api.nvim_buf_create_user_command(0, 'MarkdownPreview', function(opts)
	local subcmd = opts.fargs[1]

	if subcmd == 'start' then
		if job_id then
			vim.notify('Markdown preview already running', vim.log.levels.WARN)
			return
		end
		local output = {}
		local errors = {}

		job_id = vim.fn.jobstart({ 'gh', 'markdown-preview', vim.api.nvim_buf_get_name(0) }, {
			stdout_buffered = true,
			stderr_buffered = true,
			on_stdout = function(_, data)
				vim.list_extend(output, data)
			end,
			on_stderr = function(_, data)
				vim.list_extend(errors, data)
			end,
			on_exit = function(_, exit_code)
				job_id = nil

				if exit_code ~= 0 then
					local message = vim.tbl_isempty(errors) and ''
						or table.concat(errors, ' ')
						or table.concat(output, ' ')
						or ('gh markdown-preview exited with code %d'):format(exit_code)

					vim.schedule(function()
						local truncated_message = vim.fn.strcharpart(message, 0, max_error_chars) .. '<...>'
						vim.notify(truncated_message, vim.log.levels.ERROR, {
							title = 'MarkdownPreview failed',
						})
					end)
				end
			end,
		})

		if job_id <= 0 then
			job_id = nil
			vim.notify('Failed to start gh markdown-preview', vim.log.levels.ERROR, {
				title = 'MarkdownPreview failed',
			})
		end
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
