---@type LazyPluginSpec[]
return {
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		config = function()
			require('copilot').setup {
				copilot_node_command = vim.fn.expand '$FNM_DIR' .. '/node-versions/v22.19.0/installation/bin/node',
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = false,
				},
			}
		end,
	},
	{
		'CopilotC-Nvim/CopilotChat.nvim',
		build = 'make tiktoken',
		cmd = {
			'CopilotChat',
			'CopilotChatOpen',
			'CopilotChatToggle',
			'CopilotChatClose',
			'CopilotChatStop',
			'CopilotChatReset',
			'CopilotChatSave',
			'CopilotChatPrompts',
			'CopilotChatModels',
			'CopilotChatAgents',
		},
		dependencies = {
			{ 'zbirenbaum/copilot.lua' },
			{ 'nvim-lua/plenary.nvim' },
		},
		config = function()
			require('CopilotChat').setup {}
		end,
	},
}
