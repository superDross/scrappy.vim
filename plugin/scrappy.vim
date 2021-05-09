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
  call system('mkdir -p ' . g:scrappy_dir)
  return dirpath
endfunction


function! GetRandomScriptPath(ext = g:scrappy_default_ext)
  let randnum = system('echo $RANDOM | tr -d "\n"')
  return GetDirPath() . randnum . "." . a:ext
endfunction


function! GetScriptPath(scriptname)
  return GetDirPath() . a:scriptname
endfunction


function! OpenScript(scriptname = 0)
  if a:scriptname == 0
    let scriptname = GetRandomScriptPath()
  else
    let scriptname = GetScriptPath(a:scriptname)
  endif
  execute "edit " . scriptname
endfunction


" command! -bang -nargs=* GrepScripts
"   \ call fzf#vim#grep(
"   \   'rg --type md --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview({'dir': '~/.scrappy/'}), <bang>0)

" nnoremap <Leader>ns :GrepScripts<CR>


" Command should:
" 1. create a randomly named python script a directory called ~/.scrappy
" 2. should have a command to rename randomly name script RenameScrappy <name>
" 3. should have the option to name the scrappy file
" 4. should be able to search the files using FZF
