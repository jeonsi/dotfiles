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
local rt = require("rust-tools")

-- SETUPS

-- NvimTree
require("nvim-tree").setup()

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()

-- Lualine status bar
require("lualine").setup({
	options = {
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
})

-- Nvim Autopairs
require("nvim-autopairs").setup()

-- Git signs
require("gitsigns").setup()

-- Line highlighting
require("indent_blankline").setup({
	char = "┊",
})

-- Languages
rt.setup({
	server = {
		on_attach = on_attach,
		function(_, bufnr)
			-- Hover actions
			kmap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			kmap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
	},
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
