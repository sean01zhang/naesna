" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

" Yank to system clipboard
set clipboard=unnamed

" jk/kj sets you back to normal mode
inoremap jk <Esc>
inoremap kj <Esc>

" Chording
unmap <Space>
exmap rclick obcommand editor:context-menu
nnoremap <Space>cm :rclick
