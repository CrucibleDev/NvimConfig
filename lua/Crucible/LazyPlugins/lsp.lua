return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/nvim-cmp',
			'j-hui/fidget.nvim',
		},
		config = function()
			require('fidget').setup()
			require('mason').setup()
			require('mason-lspconfig').setup({
				ensure_installed = {
					'lua_ls',
					'rust_analyzer',
				},
				handlers = {
					function (server_name)
						require('lspconfig')[server_name].setup({})
					end,
				}
			})

			require('lspconfig').lua_ls.setup(
			{
				settings = {
					Lua = {
						diagnostics = {
							globals = {'vim'}
						},
					},
				},
			})

			local cmp = require('cmp')
			local cmp_select = {behavior = cmp.SelectBehavior.Select}
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<C-y>'] = cmp.mapping.confirm({select = true}),
					['<C-Space>'] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					-- { name = 'vsnip' }, -- For vsnip users.
					-- { name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = 'buffer' },
				}),
			})
			vim.diagnostic.config({
				update_in_insert = true,
			})
		end,
	},
}
