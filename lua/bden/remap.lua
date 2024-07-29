vim .g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex,
    { desc = "Open File explorer" }
)


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


-- your saying I can rebind another key to Esc when
-- in insertmode??? The  key that hurts my hand the most!
-- Of course I am going to do that!
vim.keymap.set("i", "<C-d>", "<Esc>",
    { desc = "Shortcut for the excape key!" }
)
vim.keymap.set("v", "<C-d>", "<Esc>",
    { desc = "Shortcut for the excape key!" }
)


-- keybinding to clear highlighting in normal mode.
vim.keymap.set("n", "<A-w>", ":noh<CR>",
    { desc = "[w]ipes the highlighting form your screen" }
)



