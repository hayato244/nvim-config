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

vim.keymap.set('n', '<Up>', ':resize -2<CR>', { desc = 'Decrease height of window' })
vim.keymap.set('n', '<Down>', ':resize +2<CR>', { desc = 'Increase height of window' })
vim.keymap.set('n', '<Right>', ':vertical resize -2<CR>', { desc = 'Decrease width of window'})
vim.keymap.set('n', '<Left>', ':vertical resize +2<CR>', { desc = 'Increase width of window' })

vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Switch to next buffer' })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = 'Switch to previous buffer' })
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>b', '<cmd>enew<CR>', { desc = 'Open new buffer' })

vim.keymap.set('n', '<leader>v', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>h', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make split windows equal in width and height' })
vim.keymap.set('n', '<leader>xs', ':close<CR>', { desc = 'Close current window' })

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

local telescope_plugins = {
	gh 'nvim-lua/plenary.nvim',
	gh 'nvim-telescope/telescope.nvim',
	gh 'nvim-telescope/telescope-ui-select.nvim',
}

vim.pack.add({
	gh 'stevearc/oil.nvim',
	gh 'nvim-tree/nvim-web-devicons',
	gh 'nvim-mini/mini.nvim',
	{
		src = gh 'nvim-treesitter/nvim-treesitter',
		version = 'main'
	},
})

vim.pack.add(telescope_plugins)
	
require("oil").setup({})

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

if vim.fn.executable 'make' == 1 then
	table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim')
end

require('telescope').setup {
	-- defaults = {
	--   mappings = {
	--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
	--   },
	-- },
	pickers = {
		find_files = {
			file_ignore_patterns = { 'node_modules', '.git', 'bin', 'obj', '.vs' },
		}
	},
	extensions = {
		['ui-select'] = { require('telescope.themes').get_dropdown() },
	},
}

-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search Select Telescope' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = 'Search current Word' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search Resume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = 'Search Commands' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
	callback = function(event)
		local buf = event.buf

		-- Find references for the word under your cursor.
		vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = 'Goto References' })

		-- Jump to the implementation of the word under your cursor.
		vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = 'Goto Implementation' })

		-- Jump to the definition of the word under your cursor.
		vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = 'Goto Definition' })

		-- Fuzzy find all the symbols in your current document.
		vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

		-- Fuzzy find all the symbols in your current workspace.
		vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

		-- Jump to the type of the word under your cursor.
		vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = 'Goto Type Definition' })
	end,
})

vim.keymap.set('n', '<leader>/', function()
	builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = 'Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>s/', function()
	builtin.live_grep {
		grep_open_files = true,
		prompt_title = 'Live Grep in Open Files',
	}
end, { desc = 'Search in Open Files' })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Search Neovim files' })
