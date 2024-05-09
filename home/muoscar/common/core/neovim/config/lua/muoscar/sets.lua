-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tabs & indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Wrap lines
vim.opt.wrap = false

-- Swap & backups
vim.opt.swapfile = false
vim.opt.backup = false

-- Persistent undo tree
vim.opt.undodir = vim.env.HOME .. '/.vim/undodir'
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Pretty colors
vim.opt.termguicolors = true

-- Scroll offset
vim.opt.scrolloff = 6

-- Unsure of what uses this, can apparently glitch when set too low
-- vim.opt.updatetime = 50
vim.opt.updatetime = 200

-- Column breakpoint
vim.opt.colorcolumn = "80"
