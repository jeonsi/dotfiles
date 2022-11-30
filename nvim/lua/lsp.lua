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

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local luasnip = require("luasnip")
local cmp = require("cmp")

local null_ls = require("null-ls")
local prettier = require("prettier")

local ih = require("inlay-hints")

-- LSP

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "clangd", "rust_analyzer", "sumneko_lua", "tsserver" }

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
    })
end

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

-- Mappings.
local opts = { noremap = true, silent = true }
kmap.set("n", "<space>e", vim.diagnostic.open_float, opts)
kmap.set("n", ",D", vim.diagnostic.goto_prev, opts)
kmap.set("n", ",d", vim.diagnostic.goto_next, opts)
kmap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Inline-hints
    ih.on_attach(client, bufnr)

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
    commands = {
        Format = {
            function()
                require("stylua-nvim").format_file()
            end,
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

-- Null-ls settings
local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<Leader>f", function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })

            -- format on save
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            vim.api.nvim_create_autocmd(event, {
                buffer = bufnr,
                group = group,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, async = async })
                end,
                desc = "[lsp] format on save",
            })
        end

        if client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("x", "<Leader>f", function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })
        end
    end,
})

-- Prettier format settings
prettier.setup({
    bin = "prettier", -- or `'prettierd'` (v0.22+)
    filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
    },
    ["null-ls"] = {
        condition = function()
            return prettier.config_exists({
                -- if `false`, skips checking `package.json` for `"prettier"` key
                check_package_json = true,
            })
        end,
        runtime_condition = function(params)
            -- return false to skip running prettier
            return true
        end,
        timeout = 5000,
    },
    cli_options = {
        arrow_parens = "always",
        bracket_spacing = true,
        bracket_same_line = false,
        embedded_language_formatting = "auto",
        end_of_line = "lf",
        html_whitespace_sensitivity = "css",
        jsx_single_quote = false,
        print_width = 80,
        prose_wrap = "preserve",
        quote_props = "as-needed",
        semi = true,
        single_attribute_per_line = false,
        single_quote = true,
        tab_width = 4,
        trailing_comma = "es5",
        use_tabs = false,
        vue_indent_script_and_style = false,
    },
})
