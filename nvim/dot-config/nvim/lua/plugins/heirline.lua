---@type LazyPluginSpec
return {
	'rebelot/heirline.nvim',
	event = 'UiEnter',
	config = function()
		local conditions = require 'heirline.conditions'
		local utils = require 'heirline.utils'

		local colors = {
			bright_bg = utils.get_highlight('Folded').bg,
			bg = utils.get_highlight('StatusLine').bg,
			fg = utils.get_highlight('StatusLine').fg,
			red = utils.get_highlight('DiagnosticError').fg,
			yellow = utils.get_highlight('DiagnosticWarn').fg,
			green = utils.get_highlight('DiagnosticOk').fg or utils.get_highlight('String').fg,
			blue = utils.get_highlight('Function').fg,
			purple = utils.get_highlight('Statement').fg,
			cyan = utils.get_highlight('Special').fg,
			orange = utils.get_highlight('Constant').fg,
			muted = utils.get_highlight('Comment').fg,
		}

		local ViMode = {
			init = function(self)
				self.mode = vim.fn.mode(1)
			end,
			static = {
				mode_names = {
					n = 'N',
					no = 'N?',
					nov = 'N?',
					noV = 'N?',
					['no\22'] = 'N?',
					niI = 'Ni',
					niR = 'Nr',
					niV = 'Nv',
					nt = 'Nt',
					v = 'V',
					vs = 'Vs',
					V = 'V_',
					Vs = 'Vs',
					['\22'] = '^V',
					['\22s'] = '^V',
					s = 'S',
					S = 'S_',
					['\19'] = '^S',
					i = 'I',
					ic = 'Ic',
					ix = 'Ix',
					R = 'R',
					Rc = 'Rc',
					Rx = 'Rx',
					Rv = 'Rv',
					Rvc = 'Rv',
					Rvx = 'Rv',
					c = 'C',
					cv = 'Ex',
					r = '...',
					rm = 'M',
					['r?'] = '?',
					['!'] = '!',
					t = 'T',
				},
				mode_colors = {
					n = 'blue',
					i = 'green',
					v = 'purple',
					V = 'purple',
					['\22'] = 'purple',
					c = 'orange',
					s = 'cyan',
					S = 'cyan',
					['\19'] = 'cyan',
					R = 'red',
					r = 'red',
					['!'] = 'red',
					t = 'green',
				},
			},
			provider = function(self)
				return ' ' .. (self.mode_names[self.mode] or self.mode) .. ' '
			end,
			hl = function(self)
				local color = self.mode_colors[self.mode:sub(1, 1)] or 'fg'
				return { fg = 'bg', bg = color, bold = true }
			end,
			update = { 'ModeChanged', pattern = '*:*' },
		}

		local Git = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict or {}
			end,
			{
				provider = function(self)
					local head = self.status_dict.head
					return head and ('  ' .. head .. ' ') or ''
				end,
				hl = { fg = 'orange' },
			},
			{
				provider = function(self)
					local added = self.status_dict.added or 0
					return added > 0 and (' +' .. added) or ''
				end,
				hl = { fg = 'green' },
			},
			{
				provider = function(self)
					local changed = self.status_dict.changed or 0
					return changed > 0 and (' ~' .. changed) or ''
				end,
				hl = { fg = 'yellow' },
			},
			{
				provider = function(self)
					local removed = self.status_dict.removed or 0
					return removed > 0 and (' -' .. removed) or ''
				end,
				hl = { fg = 'red' },
			},
			{ provider = ' ' },
		}

		local FileName = {
			provider = function()
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':~:.')
				if filename == '' then
					return '[No Name]'
				end
				if vim.fn.winwidth(0) < 80 then
					filename = vim.fn.pathshorten(filename)
				end
				return filename
			end,
			hl = { fg = 'fg' },
		}

		local FileFlags = {
			{
				condition = function()
					return vim.bo.modified
				end,
				provider = ' [+]',
				hl = { fg = 'yellow' },
			},
			{
				condition = function()
					return not vim.bo.modifiable or vim.bo.readonly
				end,
				provider = ' ',
				hl = { fg = 'red' },
			},
		}

		local Diagnostics = {
			condition = conditions.has_diagnostics,
			update = { 'DiagnosticChanged', 'BufEnter' },
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
			end,
			{
				provider = function(self)
					return self.errors > 0 and (' ' .. self.errors .. ' ') or ''
				end,
				hl = { fg = 'red' },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (' ' .. self.warnings .. ' ') or ''
				end,
				hl = { fg = 'yellow' },
			},
			{
				provider = function(self)
					return self.info > 0 and (' ' .. self.info .. ' ') or ''
				end,
				hl = { fg = 'cyan' },
			},
			{
				provider = function(self)
					return self.hints > 0 and (' ' .. self.hints .. ' ') or ''
				end,
				hl = { fg = 'green' },
			},
		}

		local LSPActive = {
			condition = conditions.lsp_attached,
			update = { 'LspAttach', 'LspDetach' },
			provider = function()
				local names = {}
				for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
					table.insert(names, client.name)
				end
				if #names == 0 then
					return ''
				end
				return '  ' .. table.concat(names, ', ') .. ' '
			end,
			hl = { fg = 'muted' },
		}

		local Tools = {
			provider = function()
				local seen = {}
				local names = {}

				local ok_conform, conform = pcall(require, 'conform')
				if ok_conform then
					for _, f in ipairs(conform.list_formatters_to_run(0)) do
						if not seen[f.name] then
							seen[f.name] = true
							table.insert(names, f.name)
						end
					end
				end

				local ok_lint, lint = pcall(require, 'lint')
				if ok_lint then
					for _, name in ipairs(lint._resolve_linter_by_ft(vim.bo.filetype)) do
						if not seen[name] then
							local linter = lint.linters[name]
							if type(linter) == 'function' then
								linter = linter()
							end
							local cmd = linter and linter.cmd
							if type(cmd) == 'function' then
								cmd = cmd()
							end
							if type(cmd) == 'string' and vim.fn.executable(cmd) == 1 then
								seen[name] = true
								table.insert(names, name)
							end
						end
					end
				end

				if #names == 0 then
					return ''
				end
				return ' ' .. table.concat(names, ', ') .. ' '
			end,
			hl = { fg = 'muted' },
		}

		local FileType = {
			provider = function()
				return vim.bo.filetype ~= '' and vim.bo.filetype or ''
			end,
			hl = { fg = 'blue' },
		}

		local Align = { provider = '%=' }
		local Space = { provider = ' ' }

		local ScrollBar = {
			static = {
				sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
				-- Another variant, because the more choice the better.
				-- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
			},
			provider = function(self)
				local curr_line = vim.api.nvim_win_get_cursor(0)[1]
				local lines = vim.api.nvim_buf_line_count(0)
				local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
				return string.rep(self.sbar[i], 2)
			end,
			hl = { fg = 'blue', bg = 'bright_bg' },
		}

		local StatusLine = {
			ViMode,
			Git,
			Space,
			FileName,
			FileFlags,
			Align,
			Diagnostics,
			LSPActive,
			Tools,
			FileType,
			Space,
			ScrollBar,
		}

		require('heirline').setup {
			statusline = StatusLine,
			opts = { colors = colors },
		}
	end,
}
