vim .g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex,
    { desc = "Open File explorer" }
)

char_under_cursor = "test"

-- allows for moving selected lines as group
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv",
    { desc = "Move selected lines down" }
)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv",
    { desc = "Move selected lines up" }
)

vim.keymap.set('n', "J", "mzJ`z",
    { desc = "Append previous line to current" }
)


vim.keymap.set('n', "<leader>p", "\"_dP")

-- Alternate movement in insert mode
vim.keymap.set('i', "<A-h>", "<Left>")
vim.keymap.set('i', "<A-j>", "<Down>")
vim.keymap.set('i', "<A-k>", "<Up>")
vim.keymap.set('i', "<A-l>", "<Right>")
vim.keymap.set('i', "<A-w>", "<S-Right>")
vim.keymap.set('i', "<A-b>", "<S-Left>")
vim.keymap.set('i', "<A-m>l", "<End>")
vim.keymap.set('i', "<A-m>h", "<Home>")
vim.keymap.set("i", "<A-f>", function ()
    vim.cmd(":BackBlock")
end
)
vim.keymap.set("i", "<A-.>", function ()
    vim.cmd(":NextBlock")
end)
vim.keymap.set("i", "<A-,>", function ()
    vim.cmd(":PriorBlock")
end)
vim.keymap.set("i", "<A-0>", function ()
    vim.cmd(":StartBlock")
end)
vim.keymap.set("i", "<A-m>s", function ()
    vim.cmd(":StartBlock")
end)
vim.keymap.set("i", "<A-m>e", function ()
    vim.cmd(":EndBlock")
end)
vim.keymap.set("i", "<A-m>f", function ()
    vim.cmd(":FrontBlock")
end)
vim.keymap.set("i", "<A-m>i", function ()
    vim.cmd(":InnerBlock")
end)
vim.keymap.set("i", "<A-m>o", function ()
    vim.cmd(":OuterBlock")
end)


-- Hotkeys to help with keys that my right hand struggles to reach
vim.keymap.set("i", "<A-q>", "<Esc>",
    { desc = "Shortcut for the excape key!" }
)
vim.keymap.set("v", "<A-q>", "<Esc>",
    { desc = "Shortcut for the excape key!" }
)
vim.keymap.set("c", "<A-q>", "<Esc>",
    { desc = "Shortcut for the excape key!" }
)

vim.keymap.set("i", "<A-r>", "^")
vim.keymap.set("c", "<A-r>", "^")
vim.keymap.set("i", "<A-Space>", "<BS>")
vim.keymap.set("c", "<A-Space>", "<BS>")
vim.keymap.set("i", "<A-u>", "_")
vim.keymap.set("c", "<A-u>", "_")
vim.keymap.set("i", "<A-;>", "=")
vim.keymap.set("c", "<A-;>", "=")
vim.keymap.set("i", "<A-p>", "+")
vim.keymap.set("c", "<A-p>", "+")
vim.keymap.set("i", "<A-->", "|" )
vim.keymap.set("c", "<A-->", "|" )
vim.keymap.set("i", "<A-'>", "<Bslash>")
vim.keymap.set("c", "<A-'>", "<Bslash>")

-- function that use the python code I have

-- keybinding to clear highlighting in normal mode.
vim.keymap.set("n", "<A-w>", ":noh<CR>",
    { desc = "[w]ipes the highlighting form your screen" }
)



