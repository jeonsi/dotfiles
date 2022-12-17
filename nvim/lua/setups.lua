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
require("lsp-config")

local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

-- SETUPS

-- NvimTree
require("nvim-tree").setup()

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()

-- Status line
require("lualine").setup({
	options = {
		theme = "auto",
	},
})

-- Nvim Autopairs
require("nvim-autopairs").setup()

-- Git signs
require("gitsigns").setup()

-- Line highlighting
require("indent_blankline").setup({
	show_end_of_line = true,
})

-- Languages
lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
})

lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
})

lspconfig.remark_ls.setup({
	on_attach = on_attach,
})

-- Null-ls
null_ls.setup({
	sources = {
		-- Formatters
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,

		-- Diagnostics
		null_ls.builtins.diagnostics.eslint,

		-- Completion
		null_ls.builtins.completion.spell,

		-- Code Actions
		null_ls.builtins.code_actions.eslint,
	},
})
