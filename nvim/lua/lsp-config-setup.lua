--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- Neovim Lua Config File by Arfan Zubi
-- LSP-CONFIG SETUP

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- General keybindings
local opts = { noremap = true, silent = true }
kmap.set("n", "<space>e", vim.diagnostic.open_float, opts)
kmap.set("n", "[d", vim.diagnostic.goto_prev, opts)
kmap.set("n", "]d", vim.diagnostic.goto_next, opts)
kmap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Language specific settings
on_attach = function(client, bufnr)
	-- Format on save
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end

	-- Mappings.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	kmap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	kmap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	kmap.set("n", "K", vim.lsp.buf.hover, bufopts)
	kmap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	kmap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	kmap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	kmap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	kmap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	kmap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	kmap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	kmap.set("n", "gr", vim.lsp.buf.references, bufopts)
	kmap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end
