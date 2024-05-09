-- Leader key
vim.g.mapleader = " "

-- Open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move lines & fix indentation
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')

-- Recenter screen after scrolling or searching
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Paste over selection but don't overwrite the register
vim.keymap.set('x', '<leader>p', '"_dP')

-- Yank, delete and change to system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

vim.keymap.set('n', '<leader>d', '"+d')
vim.keymap.set('v', '<leader>d', '"+d')
vim.keymap.set('n', '<leader>D', '"+D')

vim.keymap.set('n', '<leader>c', '"+c')
vim.keymap.set('v', '<leader>c', '"+c')
vim.keymap.set('n', '<leader>C', '"+C')

-- Replace word under cursor using :%s regex
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

-- Make current file exectuable using chmod +x
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- Echo the name of the highlight group under the cursor
vim.keymap.set('n', '<leader>hg', [[
  :echo synIDattr(synID(line('.'), col('.'), 1), 'name') . ' -> ' . synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
]])
vim.keymap.set('n', '<leader>hc', [[
    :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")
]])

-- TODO: remove this (tmp)
vim.keymap.set('n', '<leader>ss', [[
  :so ~\AppData\Local\nvim\lua\muoscar\gruber-darker-vimtex-highlight-groups.lua<CR>
]])

-- TODO: Remove temporary

vim.keymap.set('n', '<leader>yA', [[ggVGy]])
