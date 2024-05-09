--[[
It is important that you read

:help vimtex-faq-windows

and

:help vimtex-faq-treesitter
]]

return {
	"lervag/vimtex",
	lazy = false,
	config = function()
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk_engines = { _ = "-pdflatex" } -- found to be quickest
		-- puts the auxilary files in a folder instead of root
		vim.g.vimtex_compiler_latexmk = {
			aux_dir = "./tmp",
			out_dir = "./out",
		}

		-- vim.g.vimtex_compiler_method = 'tectonic'
		-- vim.g.vimtex_compiler_latexmk_engines = { _ = '-tectonic' }
		-- vim.g.vimtex_compiler_tectonic = {
		--     out_dir = './out',
		--     options = [ '--keep-logs' ],
		-- }

		-- by default vimtex will remap leader to '\'
		-- vim.g.maplocalleader = ' '

		vim.g.vimtex_view_method = "sioyek"
		vim.g.vimtex_view_use_temp_files = true -- helps with refreshing after recompilation
		vim.g.vimtex_quickfix_method = "pplatex" -- pplatex or pulp require external dependencies
		vim.g.vimtex_quickfix_mode = 0 -- 0: don't open qf window, 1: open and focus, 2: open but dont focus
		vim.g.vimtex_quickfix_open_on_warning = 0
		vim.g.vimtex_quickfix_autoclose_after_keystrokes = 3
		vim.g.tex_flavor = "latex"
		vim.g.vimtex_matchparen_enabled = 0 -- disabling helps imporve scroll preformance significantly TODO: look at using matchup (:h vimtex-af-enhanced-matchparen)
		-- vim.g.matchup_matchparen_deferred = 1

		-- toggle if using treesitter highlighting note that this disables some
		-- vimtex features. see :h vimtex-faq-treesitter
		vim.g.vimtex_syntax_enabled = 1
		vim.g.vimtex_syntax_conceal_disable = 0

		vim.keymap.set("n", "<leader>ll", [[ <CMD> VimtexCompile<CR> ]])
		vim.keymap.set("n", "<leader>lwc", [[ <CMD> VimtexCountWords<CR> ]])
		vim.keymap.set("n", "<leader>le", [[ <CMD> VimtexErrors<CR> ]])
		vim.keymap.set("n", "<leader>lv", [[ <CMD> VimtexView<CR> ]])
		vim.keymap.set("n", "<leader>ld", [[ <CMD> VimtexDocPackage<CR> ]])
		vim.keymap.set("n", "<leader>lt", function()
			vim.cmd("VimtexTocToggle")
			-- switch to toc window, should work regardless of split type
			local bufname = vim.g.vimtex_toc_config.name
			if vim.fn.bufwinid(bufname) > 0 then
				vim.api.nvim_set_current_win(vim.fn.bufwinid(bufname))

				-- rebind some of the overloads introduced by vimtex, e.g. h
				-- ToC keymaps: https://github.com/lervag/vimtex/blob/master/autoload/vimtex/toc.vim
				vim.keymap.set("n", ",h", function()
					vim.cmd("call b:toc.toggle_help()")
				end, { buffer = true })
				vim.keymap.set("n", "h", "h", { buffer = true })
				vim.keymap.set("n", ",<Space>", function()
					vim.cmd("call b:toc.activate_current(0)")
				end, { buffer = true })
				vim.keymap.del("n", "<Space>", { buffer = true })
			end
		end)
		vim.g.vimtex_toc_config = {
			show_help = 0,
			fold_enable = 1,
			fold_level_start = 1,
			indent_levels = 1,
			hotkeys_enabled = 1,
			tocdepth = 3,
			hotkeys_leader = ",",
		}

		-- Set up conceals
		vim.opt.conceallevel = 1
		vim.opt.concealcursor = "nc"
		vim.g.vimtex_syntax_custom_cmds = {
			{
				name = "hodge",
				mathmode = 1,
				concealchar = "*",
			},
			{
				name = "diff",
				mathmode = 1,
				concealchar = "d",
			},
			{
				name = "hamiltonian",
				mathmode = 1,
				concealchar = "𝓗",
			},
			{
				name = "lagrangian",
				mathmode = 1,
				concealchar = "𝓛",
			},
		}
	end,
}
