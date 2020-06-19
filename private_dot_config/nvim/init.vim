call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox' " grubox theme - https://github.com/morhetz/gruvbox

Plug 'pangloss/vim-javascript'    " JavaScript support

"in Vim 8.2 TS is supported OOTB. It is implemented by including the yats.vim plugin into Vim distribution. So I might not need this plugin
Plug 'leafgarland/typescript-vim' " TypeScript syntax

Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'peitalin/vim-jsx-typescript' " TSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'posva/vim-vue' " vue syntax
Plug 'mattn/emmet-vim' " emmet

" styled-components, diet-cola, emotion, experimental glamor/styled, and astroturf content in javascript files.
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Intellisense engine for Vim8 & Neovim, full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

" colorscheme settings
autocmd vimenter * colorscheme gruvbox

" Uncomment these two lines if js, jsx, ts, tsx syntax highlighting goes out
" of sync.
" autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" CoC extensions
" You need to install eslint-plugin-vue and similar to take advantage of
" liniting
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-vetur', 'coc-markdownlint', 'coc-actions']

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

set termguicolors
" clipboard
set clipboard+=unnamedplus
set number
set mouse=a
syntax on
