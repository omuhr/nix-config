--[[ return {
    'thimc/gruber-darker.nvim',
    config = function()
        require('gruber-darker').setup({
            -- OPTIONAL
            transparent = false, -- removes the background
            -- underline = false, -- disables underline fonts
            -- bold = false, -- disables bold fonts
        })
    end,
    lazy = false,
    priority = 1000,
} ]]
return {
	 "blazkowolf/gruber-darker.nvim",
	 lazy = false,
	 priority = 1000,
	 opts = {},
}
