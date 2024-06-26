return {
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- lsp notifications
		"j-hui/fidget.nvim",

		-- formatting
		"stevearc/conform.nvim",

		"hrsh7th/nvim-cmp",
		-- cmp completion sources
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-calc",
		"micangl/cmp-vimtex",

		-- configure lua_ls for neovim dev
		"folke/neodev.nvim",

		-- adds support for addToDictionary, disableRule, hideFalsePositive in ltex-ls
		"barreiroleo/ltex-extra.nvim",
	},

	config = function()
		-- setup conform formatting

		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				nix = { "nixfmt" },
				json = { "jq" },
				rs = { "rustfmt" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})

		-- setup lsp_zero

		local lsp_zero = require("lsp-zero")

		lsp_zero.preset("recommended")

		lsp_zero.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }
			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "<leader>vws", function()
				vim.lsp.buf.workspace_symbol()
			end, opts)
			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end, opts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_next()
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_prev()
			end, opts)
			vim.keymap.set("n", "<leader>vca", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "<leader>vrr", function()
				vim.lsp.buf.references()
			end, opts)
			vim.keymap.set("n", "<leader>vrn", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts)
			-- Format buffer using conform
			vim.keymap.set({ "n", "v" }, "<leader>fm", conform.format)
			-- at the time of writing inlay hints are a part of nightly, therefore the check for existance
			vim.keymap.set({ "n", "v" }, "<leader>vih", function()
				if vim.lsp.inlay_hint then
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end
			end)
		end)

		-- setup mason

		require("mason").setup({})
		require("mason-lspconfig").setup({})

		-- setup completion

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			-- the order of the sources reflects their priority
			sources = {
				{ name = "nvim_lsp_signature_help" },
				{ name = "calc" },
				{ name = "path" },
				{ name = "nvim_lua" },
				{ name = "luasnip", keyword_length = 2 },
				{ name = "nvim_lsp" },
				{ name = "buffer", keyword_length = 3 },
			},
			formatting = lsp_zero.cmp_format(),
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			experimental = {
				ghost_text = { hl_group = "Comment" },
			},
		})
		cmp.setup.filetype("tex", {
			sources = {
				{ name = "luasnip", keyword_length = 2 },
				{ name = "nvim_lsp_signature_help" },
				{ name = "calc" },
				{ name = "path" },
				{ name = "nvim_lua" },
				{
					name = "nvim_lsp",
					entry_filter = function(entry)
						return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
					end,
				},
				{ name = "vimtex" },
				{ name = "buffer", keyword_length = 3 },
			},
		})

		-- setup fidget

		require("fidget").setup({})

		-- setup neodev

		-- You can override the default detection using the override function
		-- EXAMPLE: If you want a certain directory to be configured differently, you can override its settings
		require("neodev").setup({
			override = function(root_dir, library)
				if root_dir:find("/etc/nixos", 1, true) == 1 then
					library.enabled = true
					library.plugins = true
				end
			end,
		})

		-- config lsp

		local lspconfig = require("lspconfig")

		lspconfig.nixd.setup({})
		lspconfig.nil_ls.setup({})

		lspconfig.lua_ls.setup({
			settings = {
				Lua = { ["hint.enable"] = true },
			},
		})

		lspconfig.rust_analyzer.setup({})

		lspconfig.pyright.setup({})

		lspconfig.clangd.setup({})
		lspconfig.ccls.setup({})

		lspconfig.taplo.setup({})

		lspconfig.texlab.setup({})
		lspconfig.ltex.setup({
			on_attach = function(client, bufnr)
				-- rest of your on_attach process.
				require("ltex_extra").setup({
					-- table <string> : languages for witch dictionaries will be loaded, e.g. { "es-AR", "en-US" }
					-- https://valentjn.github.io/ltex/supported-languages.html#natural-languages
					load_langs = { "en-US" }, -- en-US as default
					-- boolean : whether to load dictionaries on startup
					init_check = true,
					-- string : relative or absolute path to store dictionaries
					-- e.g. subfolder in the project root or the current working directory: ".ltex"
					-- e.g. shared files for all projects:  vim.fn.expand("~") .. "/.local/share/ltex"
					path = "", -- project root or current working directory
					-- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
					log_level = "none",
					-- table : configurations of the ltex language server.
					-- Only if you are calling the server from ltex_extra
					server_opts = nil,
				})
			end,
			settings = {
				ltex = {
					language = "en-US",
					additionalRules = {
						languageModel = "~/ngrams/share/languagetool/ngrams/",
					},
					latex = {
						environments = {
							nalign = "ignore", -- don't check my custom math environment called nalign
						},
					},
				},
			},
		})

		lspconfig.grammarly.setup({
			filetypes = { "markdown", "tex", "text" },
			init_options = {
				clientId = "client_",
			},
			root_dir = function(fname)
				return require("lspconfig").util.find_git_ancestor(fname) or vim.loop.os_homedir()
			end,
		})
	end,
}
