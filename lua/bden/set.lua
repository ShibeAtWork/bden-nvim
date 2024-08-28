vim.opt.guicursor = ""

-- spelling config
vim.opt.spelllang = "en_us"
vim.opt.spell = false
vim.cmd(":spellgood! config")

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- VimTex stuff
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_view_method = 'zathura'
vim.g.tex_flavor = "latex"
vim.g.conceallevel = 2
vim.cmd(":set conceallevel=2")
-- vim.g.vimtex_syntax_enable = 1
-- vim.g.vimtex_syntax_conceal_disable = 0
-- vim.g.vimtex_view_general_viewer = 'okular'
-- vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'

-- tabs and indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- latex options

vim.cmd(':set splitright')
vim.cmd(':set splitbelow')

