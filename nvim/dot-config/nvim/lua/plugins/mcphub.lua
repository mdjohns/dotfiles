---@type LazyPluginSpec
return {
	'ravitemer/mcphub.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim', -- Required for Job and HTTP requests
	},
	-- comment the following line to ensure hub will be ready at the earliest
	cmd = 'MCPHub', -- lazy load by default
	build = 'npm install -g mcp-hub@latest', -- Installs required mcp-hub npm module
	-- uncomment this if you don't want mcp-hub to be available globally or can't use -g
	-- build = 'bundled_build.lua', -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
	opts = {
		auto_approve = true, -- Auto approve mcp tool calls
		auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
		make_slash_commands = true,
		make_vars = true,
		-- use_bundled_binary = true,
	},
	config = function(opts)
		require('mcphub').setup(opts)
	end,
}
