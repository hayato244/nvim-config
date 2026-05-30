vim.cmd.colorscheme("habamax")

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.wo.signcolumn = 'yes'

vim.o.number = true
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

vim.keymap.set('n', '<leader>to', ':tabnew<CR>', { desc = 'Open new tab' })
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { desc = 'Close current tab' })
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', { desc = 'Go to next tab' })
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', { desc = 'Go to previous tab' })

vim.keymap.set('n', '<leader>v', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>h', '<C-w>s', { desc = 'Split window horizontailly' })
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

