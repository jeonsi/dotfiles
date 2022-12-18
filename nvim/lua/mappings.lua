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

-- MAPPINGS

-- Leader
g.mapleader = ","

-- Space bar enters ":" in command mode
--kmap.set("n", "<space>", ":")

-- NerdTree
kmap.set("n", "<leader>nt", ":NvimTreeToggle<cr>")

-- Split navigation using CTRL + {j, k, h, l}
kmap.set("n", "<up>", "<c-w>k")
kmap.set("n", "<down>", "<c-w>j")
kmap.set("n", "<right>", "<c-w>l")
kmap.set("n", "<left>", "<c-w>h")

-- Resize split windows using arrow keys
kmap.set("n", "<c-up>", "<c-w>-")
kmap.set("n", "<c-down>", "<c-w>+")
kmap.set("n", "<c-right>", "<c-w>>")
kmap.set("n", "<c-left>", "<c-w><")

-- Telescope
local builtin = require("telescope.builtin")
kmap.set("n", "<leader>ff", builtin.find_files, {})
kmap.set("n", "<leader>fg", builtin.live_grep, {})
kmap.set("n", "<leader>fb", builtin.buffers, {})
kmap.set("n", "<leader>fh", builtin.help_tags, {})

-- LSP
local opts = { noremap = true, silent = true }
kmap.set("n", "<space>e", vim.diagnostic.open_float, opts)
kmap.set("n", "[d", vim.diagnostic.goto_prev, opts)
kmap.set("n", "]d", vim.diagnostic.goto_next, opts)
kmap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
