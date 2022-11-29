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

-- SCRIPTS

-- Format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]

-- Colorscheme
opt.termguicolors = true
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

-- TreeSitter settings
require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all"
  ensure_installed = { 'c', 'lua', 'rust', 'bash', 'javascript', 'typescript', 'html', 'css' },

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
})
