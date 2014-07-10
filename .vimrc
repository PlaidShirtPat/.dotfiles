"theme stuff
syntax enable
colors vividchalk
" colors molokai
" let g:molokai_original = 0
let &t_Co=256

"pathogen
execute pathogen#infect()




"basic stuff
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins


"indentline config

"powerline setup
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2

"Git things
autocmd Filetype gitcommit setlocal spell textwidth=72


"syntastic
let g:syntastic_check_on_open=1

"auto-pairs config
let g:AutoPairsShortcutFastWrap = '<C-e>'

"set tabline
hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE

"rainbow paren congi
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


"keeps PWD set to whatever is in explore window
"let g:netrw_keepdir= 0 

"allow mouse usage in vim
set mouse=a
"
"editor stuff
"indentation
set expandtab
set tabstop=2
set shiftwidth=2
set number


au VimEnter syntax keyword hiNull           null nil NULL NIL conceal cchar=ø
au VimEnter syntax keyword hiThis           this conceal cchar=@
au VimEnter syntax keyword hiReturn         return conceal cchar=⇚
au VimEnter syntax keyword hiUndefined      undefined conceal cchar=¿
au VimEnter syntax keyword hiNan            NaN conceal cchar=ℕ
au VimEnter syntax keyword hiPrototype      prototype conceal cchar=¶

set cole=1
hi clear Conceal
hi Conceal cterm=NONE ctermfg=lightblue guifg=#8787ff

"js syntax stuff


"turn shit off
nnoremap Q <nop>

"maps
map <silent> <leader>rce :tabnew ~/.vimrc<enter>
map <silent> <leader>rcr :bufdo source ~/.vimrc<enter>
map <silent> <leader>ls :source Session.vim<enter>
map <silent> <leader>t :NERDTreeToggle<enter>
map <silent> <leader>cd :cd %:p:h<enter>
map <silent> <leader>o :CommandT<enter>

"split settings
"nnoremap <silent> <C-W> :q<CR>

nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <silent> <leader>= :wincmd =<CR>

set splitbelow
set splitright

"easy motion config
let g:EasyMotion_smartcase = 1
let g:EasyMotion_skipfoldedline = 0

"set easymotion leader
map <Leader> <Plug>(easymotion-prefix)

nmap <leader>s <Plug>(easymotion-s2)
nmap <leader><leader>t <Plug>(easymotion-t2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)


"scripts
" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif

function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bdi :call DeleteInactiveBufs()

"my funcs
"function MyRailsView(controller)
  "let controllerName = a:controller
  "
  ":tabnew
"endfunction
"
