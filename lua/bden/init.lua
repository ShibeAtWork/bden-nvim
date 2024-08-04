require("bden/remap")
require("bden/set")
require("bden.lazy_init")
-- require("bden.snip")
require("bden.snips_tex")

-- TODO: organize this better...
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Harpoon stuff goes here.
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)


vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)

vim.keymap.set("n", "<leader>gp", function ()
    vim.cmd(":Git push" )
end)

vim.keymap.set("n", "<leader>gu", function ()
    vim.cmd(":Git pull" )
end)
vim.keymap.set("n", "<leader>gb", function ()
    vim.cmd(":Git blame" )
end)
vim.keymap.set("n", "<leader>gc", function ()
    vim.cmd(":Git commit" )
end)
vim.keymap.set("n", "<leader>gw", function ()
    vim.cmd(":Gwrite" )
end)

-- LSP stuff
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', '<leader>ci', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>cr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  end,
})
