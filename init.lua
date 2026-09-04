local function gh(repo)
	return 'https://github.com/' .. repo
end

vim.pack.add({
	gh 'stevearc/oil.nvim',
	gh 'nvim-tree/nvim-web-devicons',
	gh 'nvim-mini/mini.nvim',
	gh 'nvim-lualine/lualine.nvim',
	gh 'j-hui/fidget.nvim',
	{
		src = gh 'saghen/blink.cmp',
		version = vim.version.range '1.*',
	},
	{
		src = gh 'nvim-treesitter/nvim-treesitter',
		version = 'main',
	},
	gh 'lewis6991/gitsigns.nvim',
	gh 'stevearc/conform.nvim',
	gh 'ibhagwan/fzf-lua',
	gh 'vague-theme/vague.nvim',
	gh 'mason-org/mason.nvim',
	gh 'neovim/nvim-lspconfig',
})

require('core.keymaps')
require('core.autocmds')
require('core.options')

require('plugins.colorscheme')
require('plugins.oil')
require('plugins.lualine')
require('plugins.fidget')
require('plugins.blink')
require('plugins.treesitter')
require('plugins.gitsigns')
require('plugins.conform')
require('plugins.fzf-lua')
require('plugins.lsp')
