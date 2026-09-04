require('mason').setup({})

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			diagnostics = { globals = { 'vim' } },
			telemetery = { enable = false },
		},
	},
})

vim.lsp.config('ts_ls', {})
vim.lsp.config('omnisharp', {})
vim.lsp.config('clangd', {})
vim.lsp.config('gopls', {})
vim.lsp.config('angularls', {})

vim.lsp.enable({
	'lua_ls',
	'ts_ls',
	'omnisharp',
	'clangd',
	'gopls',
	'angularls',
})

vim.diagnostic.config {
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = 'rounded',
		source = true,
	},
	virtual_text = {
		current_line = true,
	},
	underline = true,
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float {
				bufnr = bufnr,
				scope = 'cursor',
				focus = false,
			}
		end,
	},
}

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
	callback = function(env)
		local bufnr = env.buf

		local opts = {
			noremap = true,
			silent = true,
			buffer = bufnr,
		}

		vim.keymap.set('n', '<leader>d', function()
			vim.diagnostic.open_float({ scope = 'cursor' })
		end, opts)

		vim.keymap.set('n', '<leader>D', function()
			vim.diagnostic.open_float({ scope = 'line' })
		end, opts)
	end,
})
