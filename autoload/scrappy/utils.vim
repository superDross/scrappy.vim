" Utils.vim
"
" Various utility functions used throughout the project


function! scrappy#utils#IsInstalled(package)
  " check if the given package is installed or not
  let loaded_packages = filter(
    \ split(execute(':scriptname'), "\n"),
    \   'v:val =~? "' . a:package . '"'
    \ )
  if loaded_packages !=# []
    return 1
  endif
  return 0
endfunction
