local set = vim.opt
set.expandtab = true
set.guicursor = "sm:blinkwait0-blinkon5-blinkoff5"
set.number = true
set.regexpengine = 2
set.relativenumber = true
set.showmatch = true
set.softtabstop = 2
set.shiftwidth = 2
set.tabstop = 2
set.wildmode = "list:longest"

set.hlsearch = false
set.incsearch = true
set.scrolloff = 8
set.signcolumn = "yes"
set.isfname:append("@-@")

set.updatetime = 50

set.textwidth = 120
set.colorcolumn = "120"

set.swapfile = false
set.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

vim.cmd("filetype plugin indent on")

vim.g.markdown_recommended_style = 0
