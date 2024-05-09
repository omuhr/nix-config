return {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup({
            ensure_installed = {
                'c',
                'lua',
                'vim',
                'vimdoc',
                'python',
                'latex',
                'vimdoc',
                'rust'
            },
            auto_install = true,
            sync_install = false,
            highlight = {
                enable = true,
                -- toggle between vimtex highlighting and treesitter
                disable = { 'latex' },
                --additional_vim_regex_highlighting = true,
            },
            indent = {
                enable = true,
            },
        })
    end,
    build = ':TSUpdate',
}
