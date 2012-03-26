"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/simple-bookmark.vim
"VERSION:  0.9
"LICENSE:  MIT
let s:simple_bookmark_BookmarkNo = 0
let s:simple_bookmark_BookmarkOpen = 0

function! sbookmark#BookmarkOpen()
    exec g:simple_bookmark_BookmarkWindowSize." ".g:simple_bookmark_DefaultConfigDir.g:simple_bookmark_DefaultBookmark
    let s:simple_bookmark_BookmarkOpen = 1
    let s:simple_bookmark_BookmarkNo = bufnr('%')
endfunction
function! sbookmark#BookmarkClose()
    let s:simple_bookmark_BookmarkOpen = 0
    exec 'bw '.s:simple_bookmark_BookmarkNo
    winc p
endfunction

function! sbookmark#Bookmark()
    if s:simple_bookmark_BookmarkOpen == 0
        call sbookmark#BookmarkOpen()
    else
        call sbookmark#BookmarkClose()
    endif
endfunction

function! sbookmark#URICheck(uri)
  return escape(matchstr(a:uri, '[a-z]*:\/\/[^ >,;:]*'), '#')
endfunction

function! sbookmark#BrowseURI()
  let uri = sbookmark#URICheck(getline("."))
  if uri != ""
    call system("! open " . uri)
  else
    echo "No URI found in line."
  endif
endfunction

function! sbookmark#SetBufMapBookmark()
    set cursorline
    nnoremap <buffer><silent> e :call sbookmark#BrowseURI()<CR>
    nnoremap <buffer><silent> <CR> :call sbookmark#BrowseURI()<CR>
    nnoremap <buffer><silent> q :call sbookmark#BookmarkClose()<CR>
endfunction
