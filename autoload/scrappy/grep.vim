" Grep.vim
"
" Performs all the logic for searching scrappy files contents.


function! scrappy#grep#GrepScripts(query)
  " returns all scripts file paths that contain the given query
  let scrappydir = g:scrappy_dir . '/**/*'
  execute 'vimgrep! /\c' . a:query . '/j ' . scrappydir
  copen
endfunction


function! scrappy#grep#GrepScriptsFzfLua(args = '')
  " interactiely search scripts contents using fzf-lua
  if scrappy#utils#IsInstalled('fzf-lua')
    lua require('fzf-lua').live_grep_native({
      \ prompt = 'Grep Scripts > ',
      \ previewer='bat',
      \ rg_glob=true,
      \ cwd = vim.g.scrappy_dir,
      \ rg_opts = '--column --line-number --no-heading --color=always --smart-case --',
      \ no_esc=true
    \ })
    return
  else
    echoerr 'ibhagwan/fzf-lua is not loaded or installed'
  endif
endfunction


function! scrappy#grep#GrepScriptsFzfVim(args)
  " interactiely search scripts contents using fzf.vim
  if scrappy#utils#IsInstalled('fzf.vim')
    call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case -- ' .
    \   shellescape(a:args), 1,
    \   fzf#vim#with_preview({'dir': g:scrappy_dir}))
  else
    echoerr 'junegunn/fzf.vim is not loaded or installed'
  endif
endfunction


function! scrappy#grep#GrepScriptsFzf(args)
  " interactively search scripts contents using junegunn/fzf.vim or fzf-lua
  if has('nvim')
    return scrappy#grep#GrepScriptsFzfLua(a:args)
  endif
  return scrappy#grep#GrepScriptsFzfVim(a:args)
endfunction
