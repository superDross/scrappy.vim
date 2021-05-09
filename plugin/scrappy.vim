" scrappy.vim - Scrappy
" Author:      David Ross <https://github.com/superDross/>
" Version:     0.01


if exists('g:scrappy_dir') ==# 0
  let g:scrappy_dir = '~/.scrappy/'
endif


if exists('g:scrappy_default_ext') ==# 0
  let g:scrappy_default_ext = 'py'
endif


function! GetDirPath()
  " create and return the scrappy directory
  call system('mkdir -p ' . g:scrappy_dir)
  return expand(g:scrappy_dir)
endfunction


function! GetRandomScriptPath(ext = g:scrappy_default_ext)
  " returns a randomly named full pathed script
  let randnum = system('echo $RANDOM | tr -d "\n"')
  return GetDirPath() . randnum . "." . a:ext
endfunction


function! GetScratchPad(ext = g:scrappy_default_ext)
  " open a scratchpad, delete if already exists
  let scratchpad = GetDirPath() . "scratchpad" . "." . a:ext
  if filereadable(scratchpad)
    call delete(scratchpad)
  endif
  return scratchpad
endfunction


function! GetScriptPath(scriptname)
  " return the full path for the scriptname
  let dirpath = GetDirPath()
  if a:scriptname =~# dirpath
    return a:scriptname
  endif
  return dirpath . a:scriptname
endfunction


function! OpenScript(...)
  " open a script in the current buffer
  let scriptname = a:1 == '' ? GetScratchPad() : GetScriptPath(a:1)
  execute "edit " . scriptname
endfunction


function! GetScrappyFiles(...)
  " returns list of files in scrappy dir that partially match given string
  let searchterm = a:1 . "*"
  return globpath(g:scrappy_dir, searchterm, 0, 1)
endfunction


command! -bang -nargs=* GrepScripts
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': g:scrappy_dir}), <bang>0)
nnoremap <silent> <Plug>(grep_scripts) :GrepScripts<Return>

command! -nargs=* -complete=customlist,GetScrappyFiles Scrappy :call OpenScript(<q-args>)
nnoremap <silent> <Plug>(create_scratchpad) :Scrappy<Return>
nnoremap <silent> <Plug>(create_scratchpad_vertical) :vsplit<Bar>Scrappy<Return>
