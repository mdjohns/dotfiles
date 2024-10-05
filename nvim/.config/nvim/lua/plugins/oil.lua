return {
  'stevearc/oil.nvim',
  dependencies = { 
	  { 'echasnovski/mini.icons', version = false, config = true }
  },
  config = true,
  keys = {
	  {
		  '-', 
		  '<cmd>Oil<cr>',
		  desc = 'Open parent directory'
	  }
  },
}
