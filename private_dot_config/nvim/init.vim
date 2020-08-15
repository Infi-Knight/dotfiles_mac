" Remap leader key to ,
let g:mapleader=','

call plug#begin('~/.config/nvim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } 
Plug 'pangloss/vim-javascript'    " JavaScript support
"in Vim 8.2 TS is supported OOTB. It is implemented by including the yats.vim plugin into Vim distribution. So I might not need this plugin
" Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'HerringtonDarkholme/yats.vim' " Typescript syntax. For now yats seems better
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'peitalin/vim-jsx-typescript' " TSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'posva/vim-vue' " vue syntax
Plug 'mattn/emmet-vim' " emmet
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline' " statusline
Plug 'tpope/vim-fugitive'
Plug 'mhartington/oceanic-next' " colorscheme
Plug 'honza/vim-snippets' " code snippets
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fzf
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim' " distraction free writing in vim
Plug 'junegunn/limelight.vim'

Plug 'tpope/vim-commentary' " comment stuff  
Plug 'kana/vim-textobj-user' " defining your own text objects
Plug 'tpope/vim-surround' " text objects for surrounding text: ds, cs, ys
Plug 'tpope/vim-repeat' " provides repeat functionality for some vim plugins like vim-surround
Plug 'michaeljsmith/vim-indent-object' " Indent text object - ai, ii, aI, iI
Plug 'kana/vim-textobj-entire' " text object for entire buffer - ae, ai
Plug 'kana/vim-textobj-line' " text object for a line - al, il

" The tabular plugin must come before vim-markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown' " needs further customizations
" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" styled-components, diet-cola, emotion, experimental glamor/styled, and astroturf content in javascript files.
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Intellisense engine for Vim8 & Neovim, full language server protocol support as VSCode

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end() " Initialize plugin system

" colorscheme settings
autocmd vimenter * colorscheme OceanicNext

" Uncomment these two lines if js, jsx, ts, tsx syntax highlighting goes out
" of sync.
" autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" CoC extensions {{{
" You need to install eslint-plugin-vue and similar to take advantage of
" liniting
let g:coc_global_extensions = [
	\'coc-tsserver', 
	\'coc-json', 
	\'coc-vetur', 
	\'coc-markdownlint', 
	\'coc-actions', 
	\'coc-pairs', 
	\'coc-html', 
	\'coc-css',
	\'coc-python',
    \'coc-go',
	\'coc-markdownlint',
	\'coc-snippets',
	\'coc-explorer',
	\'coc-git',
	\'coc-emmet',
    \'coc-spell-checker',
	\'coc-pyright']


if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif
" }}} CoC extensions

" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
" }}} Spaces & Tabs

" UI Config {{{
set hidden 		     " TextEdit might fail if hidden is not set.

" both absolute and relative line numbers are enabled by default,
" which produces “hybrid” line numbers. When entering insert mode,
" relative line numbers are turned off, leaving absolute line numbers turned on. 
" This also happens when the buffer loses focus, so you can glance back at it
" to see which absolute line you were working on if you need to.
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" https://github.com/govim/govim/wiki/vimrc-tips#-fix-why-does-vim-flicker-when-i-enter-normal-mode-leave-exit-insert-mode
" set timeoutlen=1000 ttimeoutlen=0

set cursorline               " highlight current line
set noshowmode 		     " Don't dispay mode in command line (airilne already shows it)
" Open new split panes to right and bottom, which feels more natural than Vim’s default
set splitbelow
set splitright
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
" }}} UI Config

" fzf {{{
" displays fzf in a floating window when run in a modern version of Vim or Neovim
if has('nvim-0.4.0') || has("patch-8.2.0191")
    let g:fzf_layout = { 'window': {
                \ 'width': 0.9,
                \ 'height': 0.7,
                \ 'highlight': 'Comment',
                \ 'rounded': v:false } }
else
    let g:fzf_layout = { "window": "silent botright 16split enew" }
endif

" Quickly bring up the fuzzy file finder
nnoremap <silent> <Space>f :Files<CR>

" following commands (c, bc) depend upon vim-fugitive
" The :Commits and :BCommits commands are used to explore a project’s Git history. 
" The :BCommits command will limit exploration to the history associated with the 
" current buffer whilst the :Commits command will explore the complete history of the project.
let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'

nnoremap <silent> <Leader>c  :Commits<CR>
nnoremap <silent> <Leader>bc :BCommits<CR>

" Advanced Ripgrep integration
" In the default implementation of Rg, ripgrep process starts only once with the initial query
" (e.g. :Rg foo) and fzf filters the output of the process. This is okay in most cases because
" fzf is quite performant even with millions of lines, but we can make fzf completely delegate 
" its search responsibliity to ripgrep process by making it restart ripgrep whenever the query 
" string is updated. In this scenario, fzf becomes a simple selector interface rather than a fuzzy finder.
" We will name the new command all-uppercase RG so we can still access the default version.
" --bind 'change:reload:rg ... {q}' will make fzf restart ripgrep process whenever the query string,
"  denoted by {q}, is changed.
"  With --phony option, fzf will no longer perform search. The query string you type on fzf 
"  prompt is only used for restarting ripgrep process.
"  Also note that we enabled previewer with fzf#vim#with_preview.
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <Space>g :RG<CR>
" }}} fzf

" Navigation {{{
" We can use different key mappings for easy navigation between splits to 
" save a keystroke. So instead of ctrl-w then j, it’s just ctrl-j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" fzf }}}

" Markdown {{{
" limelight's Goyo.vim integration
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'top',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }
" Markdown }}}

" Golang {{{
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
let g:go_code_completion_enabled = 0 " disable code completion with omnifunc
let g:go_updatetime = 0 " use the value from 'updatetime'
let g:go_doc_keywordprg_enabled = 0 " use floating window instead of a bottom split
" }}} Golang

" airline {{{
let g:airline_powerline_fonts = 1 " make sure to install patched powerline fonts
let g:airline_theme='oceanicnext'
let g:airline_extensions = ['branch', 'hunks', 'coc'] " Enable extensions
" }}} airline

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
 inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc-explorer
:nmap <space>e :CocCommand explorer<CR>

set termguicolors
" clipboard
set clipboard+=unnamedplus
set mouse=a
syntax on

" TODO: see if ale can be correctly configured with coc to provide stuff like
" error squiggles
" TODO: remove trailing whitespace,(possibley using ale)
