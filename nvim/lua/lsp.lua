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
require("mason").setup()
require("inlay-hints").setup()

local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local luasnip = require("luasnip")
local cmp = require("cmp")
local ih = require("inlay-hints")

-- LSP

-- Mappings.
local opts = { noremap = true, silent = true }
kmap.set("n", "<space>e", vim.diagnostic.open_float, opts)
kmap.set("n", ",D", vim.diagnostic.goto_prev, opts)
kmap.set("n", ",d", vim.diagnostic.goto_next, opts)
kmap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Avoid other formatters besides null-ls
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Inline-hints
	ih.on_attach(client, bufnr)

	-- Format on save
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end

	-- Mappings.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	kmap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	kmap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	kmap.set("n", "K", vim.lsp.buf.hover, bufopts)
	kmap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	kmap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	kmap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	kmap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	kmap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	kmap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	kmap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	kmap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	kmap.set("n", "gr", vim.lsp.buf.references, bufopts)
	--kmap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Null server
null_ls.setup({
	on_attach = on_attach,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.completion.spell,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.beautysh,
		null_ls.builtins.formatting.cbfmt,
		null_ls.builtins.formatting.clang_format,
	},
})

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "clangd", "rust_analyzer", "sumneko_lua", "tsserver" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		capabilities = capabilities,
	})
end

-- Language servers
local lsp_flags = {
	debounce_text_changes = 150,
}
require("lspconfig")["sumneko_lua"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "opt", "kmap" },
			},
			hint = {
				enable = true,
			},
		},
	},
})
require("lspconfig")["tsserver"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	settings = {
		javascript = {
			inlayHints = {
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
		typescript = {
			inlayHints = {
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
	},
})
require("rust-tools").setup({
	tools = {
		on_initialized = function()
			ih.set_all()
		end,
		inlay_hints = {
			auto = false,
		},
	},
	server = {
		on_attach = on_attach,
	},
})

-- nvim-cmp setup
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})
