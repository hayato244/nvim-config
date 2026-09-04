require('oil').setup({
	default_file_explorer = true,
	delete_to_trash = false,
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
		natural_order = 'fast',
		is_always_hidden = function(name, _)
			return name == '..' or name == '.git'
		end,
		is_hidden_file = function(name, _)
			return name:match('^%.') ~= nil
		end,
	},
	use_default_keymaps = true,
})

vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })
