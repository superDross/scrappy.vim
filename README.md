# Scrappy

Scratchpad & script file generator.

Comes with completion and stores all files in a predefined directory.

## Installation

Supports neovim or vim version 8.2 or above.

Place this in your vimrc:

```vim
Plug 'superDross/scrappy.vim
```

## Usage

Open a scratchpad script in the current buffer:

```vim
:Scrappy
```

Create & store a script in the defined scrappy directory:

```vim
:Scrappy script.py
```

Use FZF to find a specific file (must have fzf.vim installed):

```vim
:FindScripts
```

Use FZF and rg to grep contents of files (must fzf.vim and ripgrep installed):

```vim
:GrepScripts
```

Mappings can be set in your vimrc file too. For Example:

```vim
nnoremap <Leader>2 <Plug>(create_scratchpad)
nnoremap <Leader>3 <Plug>(grep_scripts)
nnoremap <Leader>4 <Plug>(find_scripts)
```

## Configuration

Configure the directory to store all scripts:

```vim
let g:scrappy_dir = '~/.scrappy/'
```

Configure the default extension for the scratchpad file:

```vim
let g:scrappy_default_ext = 'py'
```
