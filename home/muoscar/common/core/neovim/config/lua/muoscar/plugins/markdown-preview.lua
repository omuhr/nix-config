return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		-- function OpenMarkdownPreview(url)
		-- 	vim.api.nvim_command("silent ! firefox --new-window " .. url)
		-- end
		vim.cmd([[
          function OpenMarkdownPreview (url)
            execute "silent ! zen --new-window " . a:url
          endfunction
        ]])
		vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
	end,
}
