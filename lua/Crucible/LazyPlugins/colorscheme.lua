return {
	{
		'rose-pine/neovim',
		lazy = false,
		priority = 1000,
		name = 'rose-pine',
		config = function()
			vim.cmd('colorscheme rose-pine')
		end,
	}
	--[[
	{
		"folke/tokyonight.nvim",
		lazy = false, -- Load this during startup if it is your main colorscheme
		priority = 1000, -- Ensure it loads before other plugins
		config = function()
			-- Load the colorscheme here
			vim.cmd("colorscheme tokyonight")
		end,
	},
	]]
}
