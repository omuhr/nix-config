call plug#begin('~/.config/nvim/autoload/plugged')
  " Add syntax and indentation support for a ton of languages
  Plug 'sheerun/vim-polyglot'
  " Add ranbow coloring to nested delimiters
  Plug 'luochen1990/rainbow'
  " Auto close delimiters
  Plug 'cohama/lexima.vim'
  " Improves interaction with delimiter
  Plug 'tpope/vim-surround'
"    " Extends repeatability with . function
"    Plug 'tpope/vim-repeat'
"    " Enables matlab interaction
"    Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }
"    " Smooth scrolling
"    Plug 'yuttie/comfortable-motion.vim'
  " Comment engine
  Plug 'preservim/nerdcommenter'
  " Move lines/blocks with alt-h,j,k,l
  Plug 'matze/vim-move'
  " File manager
  Plug 'lambdalisue/fern.vim'
"    " Nerdfont icons for fern
"    Plug 'lambdalisue/nerdfont.vim'
"    Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  " Allows fern to launch when neovim is run on a directory
  Plug 'lambdalisue/fern-hijack.vim'
  " Nord theme
  Plug 'arcticicestudio/nord-vim'
"    " One Dark theme
"    Plug 'joshdick/onedark.vim'
"    Plug 'lervag/vimtex'
  " Allow f, F, t, and T to search accros line breaks
  Plug 'dahu/vim-fanfingtastic'
"    " Autocomplete engine
"    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"    " Snippet engine
"    Plug 'SirVer/ultisnips'
"    " Snippets are separated from the engine. Add this if you want them:
"    Plug 'honza/vim-snippets'
  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " Improved environment matching
  Plug 'andymass/vim-matchup'
call plug#end()

syntax on
colorscheme nord
set termguicolors
set mouse=a
set clipboard+=unnamed
set number relativenumber
set colorcolumn=80
set splitbelow splitright
set hidden
set smarttab
set autoindent
set smartindent

let g:rainbow_active = 1

map <SPACE> <leader>

" Y yanks from cursor to end of line
nnoremap Y y$

noremap <silent><leader>f :Fern . -drawer -toggle <CR>

" Enable treesitter for vim-matchup
lua <<EOF
require'nvim-treesitter.configs'.setup {
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    -- [options]
  },
}
EOF


" Removes trailing whitespace
  function TrimWhiteSpace()
    %s/\s*$//
    ''
  endfunction

  set list listchars=trail:.,extends:>
  autocmd FileWritePre * call TrimWhiteSpace()
  autocmd FileAppendPre * call TrimWhiteSpace()
  autocmd FilterWritePre * call TrimWhiteSpace()
  autocmd BufWritePre * call TrimWhiteSpace()
