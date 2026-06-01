vim.cmd.colorscheme("habamax")

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.wo.signcolumn = 'yes'

vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.wrap = false
vim.o.linebreak = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.smartindent = true
vim.o.conceallevel = 0
vim.o.fileencoding = 'utf-8'
vim.o.updatetime = 250
vim.o.timeoutlen = 500
vim.o.undofile = true
vim.o.breakindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.signcolumn = 'yes'
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<Up>', '<cmd>resize -2<CR>', { desc = 'Decrease height of window' })
vim.keymap.set('n', '<Down>', '<cmd>resize +2<CR>', { desc = 'Increase height of window' })
vim.keymap.set('n', '<Right>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease width of window'})
vim.keymap.set('n', '<Left>', '<cmd>vertical resize +2<CR>', { desc = 'Increase width of window' })

vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Switch to next buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>bprevious<CR>', { desc = 'Switch to previous buffer' })
vim.keymap.set('n', '<leader>x', '<cmd>bdelete<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>b', '<cmd>enew<CR>', { desc = 'Open new buffer' })

vim.keymap.set('n', '<leader>v', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>h', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make split windows equal in width and height' })
vim.keymap.set('n', '<leader>xs', '<cmd>close<CR>', { desc = 'Close current window' })

vim.keymap.set('n', 'x', '"_xm', { desc = 'Delete single character without copying into register' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Vertical scroll and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Vertical scroll and center' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Find and center' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Find and center' })

vim.keymap.set('v', '<', '<gv', { desc = 'Stay in visual mode after indenting' })
vim.keymap.set('v', '>', '>gv', { desc = 'Stay in visual mode after indenting' })

vim.keymap.set('v', 'p', '"_dP', { desc = 'Keep last yanked when pasting' })

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add({
	gh 'stevearc/oil.nvim',
	gh 'nvim-tree/nvim-web-devicons',
	gh 'nvim-mini/mini.nvim',
	{
		src = gh 'nvim-treesitter/nvim-treesitter',
		version = 'main'
	},
	gh 'lewis6991/gitsigns.nvim',
	gh 'stevearc/conform.nvim',
	gh 'ibhagwan/fzf-lua'
})

require("oil").setup({
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

require("mini.statusline").setup({
	use_icons = vim.g.have_nerd_font,
	section_location = function() return '%2l:%-2v' end,
})

-- Ensure basic parsers are installed
require('nvim-treesitter').install({
	'bash',
	'c',
	'diff',
	'html',
	'lua',
	'luadoc',
	'markdown',
	'markdown_inline',
	'query',
	'vim',
	'vimdoc'
})

local function treesitter_try_attach(buf, language)
	if not vim.treesitter.language.add(language) then return end

	-- Enable syntax highlighting and other treesitter features
	vim.treesitter.start(buf, language)

	-- Check if treesitter indentation is available for this language, and if so enable it
	-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
	local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

	-- Enable treesitter based indentation
	if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local available_parsers = require('nvim-treesitter').get_available()

vim.api.nvim_create_autocmd('FileType', {
	callback = function(args)
		local buf, filetype = args.buf, args.match

		local language = vim.treesitter.language.get_lang(filetype)
		if not language then return end

		local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

		if vim.tbl_contains(installed_parsers, language) then
			-- Enable the parser if it is already installed
			treesitter_try_attach(buf, language)
		elseif vim.tbl_contains(available_parsers, language) then
			-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
			require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
		else
			-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
			treesitter_try_attach(buf, language)
		end
	end,
})

require('gitsigns').setup({
	signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
	}
})

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
	},
	formatters = {
		clang_format = {
			prepend_args = { '--style=file', '--fallback-style=LLVM' },
		},
	}
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
	require('conform').format { async = true }
end, { desc = 'Format buffer' })

require('fzf-lua').setup({})

vim.keymap.set('n', '<leader>sf', require('fzf-lua').files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>sk', require('fzf-lua').keymaps, { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader>sh', require('fzf-lua').helptags, { desc = 'Search help' })
vim.keymap.set('n', '<leader>sr', require('fzf-lua').resume, { desc = 'Search resume' })
vim.keymap.set('n', '<leader>sg', require('fzf-lua').live_grep, { desc = 'Search by grep' })
vim.keymap.set('n', '<leader>sw', require('fzf-lua').grep_cword, { desc = 'Search current word' })
vim.keymap.set('n', '<leader><leader>', require('fzf-lua').buffers, { desc = 'Find existing buffers' })

vim.keymap.set('n', '<leader>/', require('fzf-lua').blines, { desc = 'Search in current Buffer' })

