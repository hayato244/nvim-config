require('conform').setup {
	notify_on_error = true,
	format_on_save = function(bufnr)
		local enabled_filetypes = {
			-- lua = true,
			-- python = true,
		}

		if enabled_filetypes[vim.bo[bufnr].filetype] then
			return { timeout_ms = 500 }
		else
			return nil
		end
	end,
	formatters_by_ft = {
		c = { 'clang_format' },
		go = { 'gofmt', 'goimports' },
		typescript = { 'prettier', stop_after_first = true },
		html = { 'prettier', stop_after_first = true },
		htmlangular = { 'prettier', stop_after_first = true },
		css = { 'prettier', stop_after_first = true },
		scss = { 'prettier', stop_after_first = true },
	},
	formatters = {
		clang_format = {
			prepend_args = { '--style=file', '--fallback-style=LLVM' },
		},
	},
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
	require('conform').format { async = true }
end, { desc = 'Format buffer' })
