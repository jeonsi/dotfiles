--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi
-- LANGUAGE SERVERS

require("lsp-config-setup") -- local LSP config file

local lspconfig = require("lspconfig")

-- LSP servers
lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
})

lspconfig.clangd.setup({
	on_attach = on_attach,
})

lspconfig.tsserver.setup({
	on_attach = on_attach,
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	settings = { Lua = { diagnostics = { globals = { "vim", "opt", "g", "kmap", "cmd" } } } },
})

lspconfig.marksman.setup({
	on_attach = on_attach,
})

lspconfig.ltex.setup({
	on_attach = on_attach,
	filetypes = { "bib", "gitcommit", "org", "plaintex", "rst", "rnoweb", "text" },
})

lspconfig.bashls.setup({
	on_attach = on_attach,
})

lspconfig.html.setup({
	on_attach = on_attach,
})
