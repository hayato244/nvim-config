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
vim.keymap.set('n', '<Right>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease width of window' })
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
