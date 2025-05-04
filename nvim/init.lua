require("config.lazy")

-- enable syntax highlight
vim.cmd("syntax on")

-- tab / indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.ambiwidth = "double"
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.cindent = true

vim.cmd("filetype plugin indent on")

-- encoding
vim.opt.encoding = "utf-8"

-- appearance
vim.opt.number = true
vim.opt.ruler = true
vim.opt.title = true
vim.opt.laststatus = 2

-- enable clipboard
vim.opt.clipboard = "unnamedplus"

-- mouse
vim.opt.mouse = "a"

-- colorscheme
vim.cmd [[ colorscheme tokyonight ]]

-- map Esc function to C-j
vim.keymap.set("i", "<C-j>", "<Esc>", { noremap = true, silent = true })

-- move b/w windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- bufferline
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")

