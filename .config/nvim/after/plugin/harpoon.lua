local mark = require("harpoon.mark")
local ui= require("harpoon.ui")
local win = 1


vim.keymap.set("n","<leader>a",mark.add_file)
vim.keymap.set("n","<C-e>",ui.toggle_quick_menu)

vim.keymap.set("n", "<C-a>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-a>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-a>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-a>4", function() ui.nav_file(4) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_next() end)
vim.keymap.set("n", "<C-b>", function() ui.nav_prev() end)
