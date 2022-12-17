--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi

-- IMPORTS
require("vars")

-- SETTINGS

-- set termguicolors to enable highlight groups
opt.termguicolors = true

-- UTF8 encoding
opt.encoding = "UTF-8"

-- Enabling clipboard
opt.clipboard = "unnamedplus"

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

-- Always show the signcolumn
vim.opt.signcolumn = "yes"

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
opt.wildmode = "list:longest"

-- Ignoring files with certain extensions
opt.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

-- Mouse support
opt.mouse = "a"

-- Opening new split panes to right and below
opt.splitright = true
opt.splitbelow = true

-- Disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Settings for line highlighting
opt.list = true
opt.listchars:append("eol:↴")
