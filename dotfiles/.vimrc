execute pathogen#infect()
syntax on
syntax enable
set encoding=utf-8
set fileencodings=utf-8
set autoindent
set smartindent
set smarttab
set expandtab
set nowrap
set number
set relativenumber
set scrolloff=10
set cursorline
set noerrorbells
set visualbell
set t_vb=
set noswapfile
set nobackup
set ignorecase
set smartcase
set incsearch
set hlsearch
set textwidth=100
set colorcolumn=80,100
set mouse=a
set signcolumn=yes
set hidden
set cmdheight=1
set noshowmode
let mapleader = " "

" language specific tab spacing
augroup FiletypeSettings
  autocmd!
  " Python: 4 spaces, use expandtab
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent
  autocmd BufNewFile,BufRead *.c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent
  autocmd BufNewFile,BufRead *.zig setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent
  " Markdown: 4 spaces, use expandtab, wrap at 80 characters
  autocmd BufNewFile,BufRead *.md setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab textwidth=80
  " HTML, JSON, YAML, CSS, JSX: 2 spaces, use expandtab
  autocmd BufNewFile,BufRead *.html,*.json,*.yml,*.yaml,*.sql,*.css,*.jsx,*.scss setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab smartindent
  " Rust, Java: 4 spaces, use expandtab
  autocmd BufNewFile,BufRead *.rs,*.java setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent
  " JavaScript, TypeScript, TSX: 2 spaces, use expandtab
  autocmd BufNewFile,BufRead *.js,*.ts,*.tsx setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent
  " Go: 4 spaces, do NOT expand tabs
  autocmd BufNewFile,BufRead *.go setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
  " Makefiles: i have no clude
  autocmd BufNewFile,BufRead Makefile setlocal noexpandtab tabstop=8 softtabstop=0 shiftwidth=8
augroup END

" color scheme
if !has('gui_running')
  set t_Co=256
endif
set background=dark
colorscheme gruvbox

" translucent vim background on everyting including special chars and status
" lines
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight StatusLine ctermbg=NONE guibg=NONE
highlight StatusLineNC ctermbg=NONE guibg=NONE
" Remaps
" clear highlights after a file string search with "/" with enter
nnoremap <CR> :noh<CR><CR>:<backspace>
" S global search and replace
noremap S :%s//g<Left><Left>
" write and source vimrc
nmap <Leader>, :w<CR>:so %<CR>
"open file explorer
nmap <Leader><Leader> :Ex<CR>
"move selected lines up
vmap J :m '>+1<CR>gv=gv
"move selected lines down
vmap K :m '<-2<CR>gv=gv
" join lines without moving cursor
nnoremap J mzJ`z
" go to previous search so if you clear your search you can go right back 
" navigation purpose search for method or variable name and navigate from there
" and return
nnoremap N Nzzzv
" scroll half a page up and center cursor same for scroll down
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
"always shows status line in every pane
set laststatus=2
" fzf
let g:fzf_vim = {}
" Basic fzf.vim configuration
let g:fzf_command_prefix = 'Fzf'
let g:fzf_vim.preview_window = ['hidden,right,50%,<70(up,75%)']
let g:fzf_layout = { 'down': '~80%' }
" Key mappings for fzf.vim
nnoremap <leader>fv :FzfFiles<CR>
nnoremap <leader>fb :FzfBuffers<CR>
nnoremap <leader>h :FzfHistory<CR>
nnoremap <leader>fs :FzfRg<CR>
nnoremap <leader>fg :FzfGFiles?<CR>
nnoremap <leader>fG :FzfGFiles<CR>
" gpt interactions
command! System edit /home/user/devenv/ai/.system.md
command! User edit /home/user/devenv/ai/.user.md
command! Response edit /home/user/devenv/ai/.response.md
nnoremap <leader>as :System<CR>
nnoremap <leader>au :User<CR>
nnoremap <leader>ar :Response<CR>
" vim-lsp
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_echo_delay = 200
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 200
let g:lsp_diagnostics_highlights_enabled = 0
let g:lsp_diagnostics_signs_insert_mode_enabled = 1
let g:lsp_diagnostics_signs_delay = 200
let g:lsp_document_highlight_enabled = 0
" vim-lsp-settings
imap <c-l> <Plug>(asyncomplete_force_refresh)
let g:asyncomplete_auto_popup = 0

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction
" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
