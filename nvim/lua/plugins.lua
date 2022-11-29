--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi


-- PLUGINS
require('paq') {
    'savq/paq-nvim'; -- Let Paq manage itself
    'nvim-lualine/lualine.nvim'; -- Status line

    -- LSP
    'neovim/nvim-lspconfig'; -- LSP
    'williamboman/mason.nvim'; -- Manager for LSP, DAP, linters and formatters
    'hrsh7th/nvim-cmp'; -- Autocompletion plugin
    'hrsh7th/cmp-nvim-lsp'; -- LSP source for nvim-cmp
    'saadparwaiz1/cmp_luasnip'; -- Snippets source for nvim-cmp
    'L3MON4D3/LuaSnip'; -- Snippets plugin

    -- Tools
    'preservim/nerdtree'; -- NerdTree
    'ryanoasis/vim-devicons'; -- Icons for NerdTree
    'nvim-treesitter/nvim-treesitter'; -- TreeSitter
    'nvim-lua/plenary.nvim'; -- Dependency of Telescope
    'nvim-telescope/telescope.nvim'; -- Telescope
    'jiangmiao/auto-pairs'; -- Auto Pairs

    -- Search
    'junegunn/fzf'; -- FZF

    -- Themes
    'neanias/everforest-nvim'; -- Everforest
}
