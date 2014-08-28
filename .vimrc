"theme stuff
syntax enable
colors jellybeans
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



"todo

de

"syntastic
let g:syntastic_check_on_open=1

"auto-pairs config
let g:AutoPairsShortcutFastWrap = '<C-e>'
map <silent> <leader>p :call AutoPairsToggle()<enter>


"set tabline
hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE

highlight clear SignColumn   

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

set relativenumber
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
map <silent> <leader>m :MaximizerToggle!<enter>
map <silent> <leader>Q :wqa<enter>

"split settings
"nnoremap <silent> <C-W> :q<CR>

nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <silent> <leader>= :wincmd =<CR>

set splitbelow
set splitright

" "easy motion config
" let g:EasyMotion_smartcase = 1
" let g:EasyMotion_skipfoldedline = 0

" "set easymotion leader
" map <Leader> <Plug>(easymotion-prefix)

" nmap <leader>s <Plug>(easymotion-s2)
" nmap <leader><leader>t <Plug>(easymotion-t2)
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)

" " These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)


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

function! FindTodos()
  :noautocmd vimgrep /TODO/ **/*
endfunction
command! Todo :call FindTodos()

"my funcs
"function MyRailsView(controller)
  "let controllerName = a:controller
  "
  ":tabnew
"endfunction
"
"
"
"
"
"VERSION INFO
"VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Jan  2 2014 19:39:47)
" Included patches: 1-52
" Modified by pkg-vim-maintainers@lists.alioth.debian.org
" Compiled by buildd@
" Huge version with GTK2-GNOME GUI.  Features included (+) or not (-):
" +acl             +clientserver    +cscope          +emacs_tags      +folding         +keymap          +menu            +mouse_netterm   +netbeans_intg   -python3         -sniff           +tcl             +virtualedit     +writebackup
" +arabic          +clipboard       +cursorbind      +eval            -footer          +langmap         +mksession       +mouse_sgr       +path_extra      +quickfix        +startuptime     +terminfo        +visual          +X11
" +autocmd         +cmdline_compl   +cursorshape     +ex_extra        +fork()          +libcall         +modify_fname    -mouse_sysmouse  +perl            +reltime         +statusline      +termresponse    +visualextra     -xfontset
" +balloon_eval    +cmdline_hist    +dialog_con_gui  +extra_search    +gettext         +linebreak       +mouse           +mouse_urxvt     +persistent_undo +rightleft       -sun_workshop    +textobjects     +viminfo         +xim
" +browse          +cmdline_info    +diff            +farsi           -hangul_input    +lispindent      +mouseshape      +mouse_xterm     +postscript      +ruby            +syntax          +title           +vreplace        +xsmp_interact
" ++builtin_terms  +comments        +digraphs        +file_in_path    +iconv           +listcmds        +mouse_dec       +multi_byte      +printer         +scrollbind      +tag_binary      +toolbar         +wildignore      +xterm_clipboard
" +byte_offset     +conceal         +dnd             +find_in_path    +insert_expand   +localmap        +mouse_gpm       +multi_lang      +profile         +signs           +tag_old_static  +user_commands   +wildmenu        -xterm_save
" +cindent         +cryptv          -ebcdic          +float           +jumplist        +lua             -mouse_jsbterm   -mzscheme        +python          +smartindent     -tag_any_white   +vertsplit       +windows         +xpm
"    system vimrc file: "$VIM/vimrc"
"      user vimrc file: "$HOME/.vimrc"
"  2nd user vimrc file: "~/.vim/vimrc"
"       user exrc file: "$HOME/.exrc"
"   system gvimrc file: "$VIM/gvimrc"
"     user gvimrc file: "$HOME/.gvimrc"
" 2nd user gvimrc file: "~/.vim/gvimrc"
"     system menu file: "$VIMRUNTIME/menu.vim"
"   fall-back for $VIM: "/usr/share/vim"
" Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H -DFEAT_GUI_GTK  -pthread -I/usr/include/gtk-2.0 -I/usr/lib/x86_64-linux-gnu/gtk-2.0/include -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/pango-1.
" 0 -I/usr/include/gio-unix-2.0/ -I/usr/include/freetype2 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/pixman-1 -I/usr/include/libpng12 -I/usr/include/harfbuzz   -pthread -DORBIT2=1 -D_REENTRANT -I/us
" r/include/libgnomeui-2.0 -I/usr/include/libart-2.0 -I/usr/include/gconf/2 -I/usr/include/gnome-keyring-1 -I/usr/include/libgnome-2.0 -I/usr/include/libbonoboui-2.0 -I/usr/include/libgnomecanvas-2.0 -I/usr/include/gtk-2.0 -I/usr/include/g
" dk-pixbuf-2.0 -I/usr/include/gnome-vfs-2.0 -I/usr/lib/x86_64-linux-gnu/gnome-vfs-2.0/include -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr
" /include/orbit-2.0 -I/usr/include/libbonobo-2.0 -I/usr/include/bonobo-activation-2.0 -I/usr/include/libxml2 -I/usr/include/pango-1.0 -I/usr/include/gail-1.0 -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/atk-1.0 -I/usr/l
" ib/x86_64-linux-gnu/gtk-2.0/include -I/usr/include/cairo -I/usr/include/gio-unix-2.0/ -I/usr/include/pixman-1 -I/usr/include/libpng12     -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -U_FORTIFY_SOUR
" CE -D_FORTIFY_SOURCE=1     -I/usr/include/tcl8.6  -D_REENTRANT=1  -D_THREAD_SAFE=1  -D_LARGEFILE64_SOURCE=1
" Linking: gcc   -L. -Wl,-Bsymbolic-functions -Wl,-z,relro -rdynamic -Wl,-export-dynamic -Wl,-E  -Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,--as-needed -o vim   -lgtk-x11-2.0 -lgdk-x11-2.0 -latk-1.0 -lgio-2.0 -lpangoft2-1.0 -lpangocairo-1.0
"  -lgdk_pixbuf-2.0 -lcairo -lpango-1.0 -lfontconfig -lgobject-2.0 -lglib-2.0 -lfreetype     -lgnomeui-2 -lSM -lICE -lbonoboui-2 -lgnomevfs-2 -lgnomecanvas-2 -lgnome-2 -lpopt -lbonobo-2 -lbonobo-activation -lORBit-2 -lart_lgpl_2 -lgtk-x11-
" 2.0 -lgdk-x11-2.0 -latk-1.0 -lgio-2.0 -lpangoft2-1.0 -lpangocairo-1.0 -lgdk_pixbuf-2.0 -lcairo -lpango-1.0 -lfontconfig -lfreetype -lgconf-2 -lgthread-2.0 -lgmodule-2.0 -lgobject-2.0 -lglib-2.0   -lSM -lICE -lXpm -lXt -lX11 -lXdmcp -lSM
" -lICE  -lm -ltinfo -lnsl  -lselinux  -lacl -lattr -lgpm -ldl  -L/usr/lib -llua5.2 -Wl,-E  -fstack-protector -L/usr/local/lib  -L/usr/lib/perl/5.18/CORE -lperl -ldl -lm -lpthread -lcrypt -L/usr/lib/python2.7/config-x86_64-linux-gnu -lpyth
" on2.7 -lpthread -ldl -lutil -lm -Xlinker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions  -L/usr/lib/x86_64-linux-gnu -ltcl8.6 -ldl -lz -lpthread -lieee -lm -lruby-1.9.1 -lpthread -lrt -ldl -lcrypt -lm  -L/usr/lib
