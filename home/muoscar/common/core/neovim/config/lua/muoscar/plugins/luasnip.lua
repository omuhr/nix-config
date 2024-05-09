return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		"omuhr/luasnip-latex-snippets.nvim",
	},
	config = function()
		require("luasnip-latex-snippets").setup()

		local ls = require("luasnip")

		vim.keymap.set({ "i" }, "<C-k>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-j>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-l>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })

		ls.config.set_config({
			-- This tells LuaSnip to remember to keep around the last snippet.
			-- You can jump back into it even if you move outside of the selection
			history = true,

			-- This one is cool cause if you have dynamic snippets, it updates as you type!
			updateevents = "TextChanged,TextChangedI",

			-- Autosnippets:
			enable_autosnippets = true,

			-- Crazy highlights!!
			-- #vid3
			-- ext_opts = nil,
			-- ext_opts = {
			--     [types.choiceNode] = {
			--         active = {
			--             virt_text = { { " « ", "NonTest" } },
			--         },
			--     },
			-- },
		})
	end,
}
