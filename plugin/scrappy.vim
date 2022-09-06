" scrappy.vim - Scrappy
" Author:      David Ross <https://github.com/superDross/>
" Version:     0.01


if exists('g:scrappy_dir') ==# 0
  let g:scrappy_dir = '~/.scrappy/'
endif


if exists('g:scrappy_default_ext') ==# 0
  let g:scrappy_default_ext = 'py'
endif


function! GetScrappyDirPath()
  " create and return the scrappy directory
  call system('mkdir -p ' . g:scrappy_dir)
  return expand(g:scrappy_dir)
endfunction


function! GetRandomScriptPath(ext = g:scrappy_default_ext)
  " returns a randomly named full pathed script
  let randnum = system('echo $RANDOM | tr -d "\n"')
  return GetScrappyDirPath() . randnum . "." . a:ext
endfunction


function! GetScratchPad(ext = g:scrappy_default_ext)
  " open a scratchpad, delete if already exists
  let scratchpad = GetScrappyDirPath() . "scratchpad" . "." . a:ext
  if filereadable(scratchpad)
    call delete(scratchpad)
  endif
  return scratchpad
endfunction


function! GetScriptPath(scriptname)
  " return the full path for the scriptname
  let dirpath = GetScrappyDirPath()
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


if get(g:, 'scrappy_use_fzf_default', 0)
  command! -nargs=* GrepScripts :call scrappy#grep#GrepScriptsFzf(<q-args>)
else
  command! -nargs=1 GrepScripts :call scrappy#grep#GrepScripts(<f-args>)
endif

command! -nargs=* GrepScriptsFzf :call scrappy#grep#GrepScriptsFzf(<q-args>)
command! -nargs=* -complete=customlist,GetScrappyFiles Scrappy :call OpenScript(<q-args>)
command! -bang -nargs=* FindScripts
      \ call fzf#vim#files(g:scrappy_dir, {'options': ['--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']})


nnoremap <silent> <Plug>(grep_scripts) :GrepScripts<Return>
nnoremap <silent> <Plug>(grep_scripts_fzf) :GrepScriptsFzf<Return>
nnoremap <silent> <Plug>(create_scratchpad) :Scrappy<Return>
nnoremap <silent> <Plug>(create_scratchpad_vertical) :vsplit<Bar>Scrappy<Return>
nnoremap <silent> <Plug>(find_scripts) :FindScripts<Return>
