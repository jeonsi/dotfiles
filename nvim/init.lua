-- 
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--                                                   
-- Neovim Lua Config File by Arfan Zubi


-- VARIABLES
local vim = vim
local opt = vim.opt
local g = vim.g
local kmap = vim.keymap

-- UTF8 encoding
opt.encoding = 'UTF-8'

-- Enabling clipboard
opt.clipboard = 'unnamedplus'

-- Line numbers
opt.number = true

-- Relative line numbers
opt.relativenumber = true

-- Horizontal cursor line
opt.cursorline = true

-- Vertical cursor line
opt.cursorcolumn = true

-- Shift width
opt.shiftwidth = 4

-- Tab width
opt.tabstop = 4

-- Space characters instead of tabs
opt.expandtab = true

-- Disable backup files
opt.backup = false
opt.writebackup = false

-- Do not let cursor scroll below or above N number of lines when scrolling
opt.scrolloff = 10

-- Wrap lines
opt.wrap = true

-- Preserve indentation of virtual line
opt.breakindent = true

-- Incrementally highlight matching characters while typing
opt.incsearch = true

-- Ignoring captial letters during search
opt.ignorecase = true

-- Overriding ignorecase option if searching for capital letters
opt.smartcase = true

-- Showing partial command on last line
opt.showcmd = true

-- Showing mode on last line
opt.showmode = true

-- Showing matching words during search
opt.showmatch = true

-- Search highlighting
opt.hlsearch = false

-- Command history
opt.history = 1000

-- Auto completion menu after pressing TAB
opt.wildmenu = true

-- Bash-like completion
opt.wildmode = 'list:longest'

-- Ignoring files with certain extensions
opt.wildignore = '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx'

-- Mouse support
opt.mouse = 'a'

-- Opening new split panes to right and below
opt.splitright = true
opt.splitbelow = true

-- PLUGINS
require 'paq' {
    'savq/paq-nvim';                  -- Let Paq manage itself
    'neovim/nvim-lspconfig';          -- LSP
    'nvim-lualine/lualine.nvim';      -- Status line

    -- Tools
    'preservim/nerdtree';             -- NerdTree    
    'ryanoasis/vim-devicons';         -- Icons for NerdTree
    'nvim-treesitter/nvim-treesitter';-- TreeSitter
    'nvim-lua/plenary.nvim';          -- Dependency of Telescope
    'nvim-telescope/telescope.nvim';  -- Telescope
    'jiangmiao/auto-pairs';           -- Auto Pairs

    -- Search
    'junegunn/fzf';                   -- FZF

    -- Themes
    'neanias/everforest-nvim';        -- Everforest
}

-- SCRIPTS

-- Colorscheme
vim.cmd('colorscheme everforest')

-- Status line
require('lualine').setup({
  options = {
    theme = 'auto',
  }
})

-- Run "xrdb" after writing .Xresources
vim.cmd('autocmd BufWritePost ~/.Xresources !xrdb %')

-- Show hidden NerdTree files
g.NERDTreeShowHidden = 1

-- LSP
require('lspconfig').bashls.setup{}

-- TreeSitter settings
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    enable = true,

    -- list of language that will be disabled
    disable = {},

    additional_vim_regex_highlighting = false,
  },
}

-- MAPPINGS

-- Leader
g.mapleader = ','

-- Space bar enters ":" in command mode
kmap.set('n', '<space>', ':')

-- NerdTree 
kmap.set('n', '<leader>nt', ':NERDTreeToggle<cr>')

-- Split navigation using CTRL + {j, k, h, l}
kmap.set('n', '<c-j>', '<c-w>j')
kmap.set('n', '<c-k>', '<c-w>k')
kmap.set('n', '<c-h>', '<c-w>h')
kmap.set('n', '<c-l>', '<c-w>l')

-- Resize split windows using arrow keys
kmap.set('n', '<up>', '<c-w>+')
kmap.set('n', '<down>', '<c-w>-')
kmap.set('n', '<right>', '<c-w>>')
kmap.set('n', '<left>', '<c-w><')

-- Telescope
local builtin = require('telescope.builtin')
kmap.set('n', '<leader>ff', builtin.find_files, {})
kmap.set('n', '<leader>fg', builtin.live_grep, {})
kmap.set('n', '<leader>fb', builtin.buffers, {})
kmap.set('n', '<leader>fh', builtin.help_tags, {})
