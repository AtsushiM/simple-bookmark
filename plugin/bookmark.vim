"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/simple-bookmark.vim
"VERSION:  0.9
"LICENSE:  MIT

let g:simple_bookmark_PluginDir = expand('<sfile>:p:h:h').'/'
let g:simple_bookmark_TemplateDir = g:simple_memo_PluginDir.'template/'
let g:simple_bookmark_SubDir = g:simple_memo_PluginDir.'sub/'

if !exists("g:simple_bookmark_DefaultConfigDir")
    let g:simple_bookmark_DefaultConfigDir = $HOME.'/.simple-bookmark/'
endif
if !exists("g:simple_bookmark_DefaultBookmark")
    let g:simple_bookmark_DefaultBookmark = '~Bookmark~'
endif
if !exists("g:simple_bookmark_BookmarkWindowSize")
    let g:simple_bookmark_BookmarkWindowSize = 'topleft 50vs'
endif

" config
if !isdirectory(g:simple_bookmark_DefaultConfigDir)
    call mkdir(g:simple_bookmark_DefaultConfigDir)
endif
let s:simple_bookmark_DefaultBookmark = g:simple_bookmark_DefaultConfigDir.g:simple_bookmark_DefaultBookmark
if !filereadable(s:simple_bookmark_DefaultBookmark)
    call system('cp '.g:simple_bookmark_TemplateDir.g:simple_bookmark_DefaultBookmark.' '.g:simple_bookmark_DefaultConfigDir.g:simple_bookmark_DefaultBookmark)
endif

command! SBookmark call sbookmark#Bookmark()
exec 'au BufRead '.g:simple_bookmark_DefaultBookmark.' call sbookmark#SetBufMapBookmark()'
exec 'au BufWinLeave '.g:simple_bookmark_DefaultBookmark.' call sbookmark#BookmarkClose()'
