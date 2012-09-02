" langage specific tokens
let s:tokens = {}
call extend(s:tokens, {'\"'  : ['vim']})
call extend(s:tokens, {'--'  : ['haskell']})
call extend(s:tokens, {'\/\/': ['javascript', 'java', 'c', 'less', 'css']})
call extend(s:tokens, {'#'   : ['coffee', 'python', 'ruby', 'jproperties', 'conf', 'sh', 'zsh']})

function GetTokenFor(syntax)
   for [key, value] in items(s:tokens)
      if index(value, a:syntax) >= 0
         return key
      endif
   endfor
   return "0"
endfunction

function s:do()
   let token = GetTokenFor(b:current_syntax)
   if token != "0"
      exe 's/^/'.token.' /'
      exe 'noh'
      silent! call repeat#set("\<Plug>MuCommentDo",v:count)
   endif
endfunction
noremap <silent><Plug>MuCommentDo :call <SID>do()<CR>

function s:undo()
   let token = GetTokenFor(b:current_syntax)
   if token != "0"
      exe 'silent!s/^\(\ *\)'.token.'\ \?/\1/'
      exe 'noh'
      silent! call repeat#set("\<Plug>MuCommentUndo",v:count)
   endif
endfunction
noremap <silent><Plug>MuCommentUndo :call <SID>undo()<CR>

" default mappings
map <Leader>c <Plug>MuCommentDo
map <Leader>C <Plug>MuCommentUndo
