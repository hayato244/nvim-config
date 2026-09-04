local group = vim.api.nvim_create_augroup('user-config', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = group,
	callback = function()
		vim.hl.on_yank()
	end,
})
