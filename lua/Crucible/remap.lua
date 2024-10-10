vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Goes to netrw or file explorer
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'file [E]xplorer [netrw]' })

--INFO: MY KEYBINDS
vim.keymap.set('i', 'jj', '<Esc>')

--  NOTE: TERMINAL KEYBINDS [CREATE REMOVE SWITCH]
vim.keymap.set('n', '<F6>', '<C-W>v<CR><C-W>20<:terminal<CR>', { desc = 'Creates terminal' })
vim.keymap.set('t', '<F7>', '<C-\\><C-n>:bw!<CR>', { desc = 'Removes terminal' })
vim.keymap.set('t', '<TAB>', '<C-\\><C-n><C-w>h', { desc = 'Switches to current buffer from terminal' })

vim.keymap.set('n', '<Leader><TAB>', function()
	local found_terminal = false

	-- Check if the current window is a terminal window
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == 'terminal' then
			found_terminal = true
			vim.api.nvim_set_current_win(win)
			vim.cmd 'startinsert'
		end
	end

	-- If no terminal is found, show a message
	if not found_terminal then
		print 'No terminal found! Press <F6> to open one'
	end
end, { desc = 'Switch to terminal window' })
--INFO: ENDOF MY KEYBINDS

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
--Simplified buffer moves
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--lsp keybinds
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('crucible-lsp-attach', { clear = true }),
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set('n', '<leader>cg', function() vim.lsp.buf.definition() end,
			{ buffer = e.buf, desc = '[G]o to Definition' })

		vim.keymap.set('n', '<leader>cH', function() vim.lsp.buf.hover() end,
			{ buffer = e.buf, desc = '[H]over Documentation' })

		vim.keymap.set('n', '<leader>ci', function() vim.lsp.buf.implementation() end,
			{ buffer = e.buf, desc = 'Go to [I]mplementation' })

		vim.keymap.set('n', '<leader>cn', function() vim.lsp.buf.rename() end,
			{ buffer = e.buf, desc = 'Re[n]ame Symbol' })

		vim.keymap.set('n', '<leader>cr', function() vim.lsp.buf.references() end,
			{ buffer = e.buf, desc = 'Go to [R]eferences' })

		vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end,
			{ buffer = e.buf, desc = 'Code [A]ction' })

		vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end,
			{ buffer = e.buf, desc = '[F]ormat file' })
	end,
})
