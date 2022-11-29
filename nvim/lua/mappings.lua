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
require('vars')

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
