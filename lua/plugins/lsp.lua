return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"cssls",
					"html",
					"emmet_ls",
					"ts_ls",
					"gopls",
					"svelte",
                    "rust_analyzer",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
			lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true

			lspconfig.emmet_ls.setup({
				capabilities = lsp_capabilities,
				filetypes = {
					"css",
					"html",
					"javascript",
					"javascriptreact",
					"sass",
					"scss",
					"svelte",
					"typescriptreact",
				},
				init_options = {
					html = {
						options = {
							-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
							["bem.enabled"] = true,
						},
					},
				},
			})

			lspconfig.html.setup({
				capabilities = lsp_capabilities,
            })
			lspconfig.cssls.setup({
				capabilities = lsp_capabilities,
            })

            -- for rust development
            lspconfig.rust_analyzer.setup({
                capabilities = lsp_capabilities,
                on_attach = function (client)
                    client.server_capabilities.documentFormattingProvider = true
                end
            })


			-- lsp lua
			lspconfig.lua_ls.setup({
				capabilities = lsp_capabilities,
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = true
				end,
			})
			-- lsp javascript
			lspconfig.ts_ls.setup({
				capabilities = lsp_capabilities,
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = true
				end,
			})
			-- lsp svelte
			lspconfig.svelte.setup({
				capabilities = lsp_capabilities,
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = true
				end,
			})
			-- lsp go
			lspconfig.gopls.setup({
				capabilities = lsp_capabilities,
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = true
				end,
			})

			local opts = { noremap = true, silent = true }

            opts.desc = "Goto defenition code"
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

            opts.desc = "Goto declaration code"
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            opts.desc = "Goto implementation code"
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

            -- code actions
            opts.desc = "Run code action in code"
            vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

            opts.desc = "Hover to code"
            vim.keymap.set("n", 'K', vim.lsp.buf.hover, opts)

            opts.desc = "Goto prev docs code"
			vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, opts)
            opts.desc = "Goto next docs code"
			vim.keymap.set("n", "<A-p>", vim.diagnostic.goto_next, opts)

            opts.desc = "Rename a variable"
			vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)

            opts.desc = "Open signature help"
			vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, opts)

            opts.desc = "Add workspace folder"
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)

            opts.desc = "Remove workspace folder"
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)

            opts.desc = "List workspace folders"
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)

            opts.desc = "Goto type defenition"
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)

            opts.desc = "References in code"
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

            opts.desc = "Open diagnostik in float"
			vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, opts)

            opts.desc = "Set location diagnostic"
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
		end,
	},
}
