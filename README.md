# telescope-rails.nvim

[ctrlp-rails](https://github.com/iurifq/ctrlp-rails.vim) for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

## Installation

Lazy:
```
{'jackcooperusesvim/telescope-rails.nvim'}
```

## Setup

Load this extension.

```
require("telescope").load_extension("rails")
```

(optional) Add shortcuts.
```
nnoremap <leader>rs :Telescope rails specs<CR>
nnoremap <leader>rc :Telescope rails controllers<CR>
nnoremap <leader>rm :Telescope rails models<CR>
nnoremap <leader>rv :Telescope rails views<CR>
nnoremap <leader>ri :Telescope rails migrations<CR>
nnoremap <leader>rl :Telescope rails libs<CR>
```

## Usage


```
:Telescope rails controllers
:Telescope rails specs
:Telescope rails models
:Telescope rails views
:Telescope rails migrations
:Telescope rails libs
```

