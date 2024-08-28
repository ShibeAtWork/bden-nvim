os = require('os')

TimeStamp = function ()
    return os.date('%m-%d-%y %H:%M')
end

TimeStampFile = function ()
    return os.date('%m-%d-%y--%H-%M')
end

local _time_stamp_local = TimeStamp()

vim.keymap.set('i', "<C-F12>", function ()
    vim.keymap.set('i', '<C-F11>', TimeStamp())
end)


vim.keymap.set('i', "<C-F10>", function ()
    vim.keymap.set('i', '<C-F11>', TimeStampFile())
end)


vim.keymap.set('i', "<C-F11>", _time_stamp_local)

vim.keymap.set('i', "<A-5>", "<C-F12><C-F11>", {remap=true})
vim.keymap.set('i', "<A-6>", "<C-F10><C-F11>", {remap=true})

vim.keymap.set('c', "<A-6>", "<C-F10><C-F11>", {remap=true})
vim.keymap.set('c', "<A-6>", "<C-F10><C-F11>", {remap=true})
