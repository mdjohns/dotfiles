---@type LazyPluginSpec[]
return {
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		opts = {
			panel = {
				enabled = false,
			},
			suggestion = {
				enabled = false,
			},
		},
		config = function(opts)
			require('copilot').setup(opts)
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
			{ 'nvim-lua/plenary.nvim', branch = 'master' },
		},
		---@type CopilotChat.config
		opts = {},
		config = function(opts)
			require('CopilotChat').setup(opts)
		end,
	},
}
